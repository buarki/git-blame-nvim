# git-blame

Small yet useful nvim plugin created for fun to get more into nvim ecosystem. Feel free to use it and improvements are more than welcome, just open up a pull request :)

## Instalation

If you are using Lazy just add a plugin returning this one:

```lua
{
    "buarki/git-blame-nvim",
    config = function()
        require("git_blame").setup()
    end
}
```

## Usage
- Hover the line you want to check info
- Press your leader+gb

