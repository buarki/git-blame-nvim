local M = {}

local extmark_id = nil
local ns_id = vim.api.nvim_create_namespace('git_blame_ns')

function M.get_git_blame()
    local file = vim.fn.expand("%:p")
    local line = vim.fn.line(".")
    local cmd = "git blame -L " .. line .. "," .. line .. " -- " .. file
    local output = vim.fn.systemlist(cmd)

    if #output == 0 or string.find(output[1], "^fatal:") then
        print("No git blame info available")
        return
    end

    local parts = vim.split(output[1], "%s+")
    local hash = parts[1]
    local author = parts[2]:gsub("[()]", "")
    local blame_msg = "🔍 Last edited by: " .. author .. " in commit " .. hash

    local bufnr = vim.fn.bufnr('%')

    if extmark_id then
        vim.api.nvim_buf_del_extmark(bufnr, ns_id, extmark_id)
        extmark_id = nil
    end

    extmark_id = vim.api.nvim_buf_set_extmark(bufnr, ns_id, line - 1, -1, {
        virt_text = {{blame_msg, 'Comment'}},
        virt_text_pos = 'inline',
        hl_mode = 'combine',
    })

    vim.cmd('redraw')
end

function M.setup()

    vim.api.nvim_set_keymap("n", "<Leader>gb", ":lua require('gitlens.git_blame').get_git_blame()<CR>", { noremap = true, silent = true })
end

return M

