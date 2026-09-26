# terminal-theme.nvim

A Neovim colorscheme scaffold. The theme is ready for its palette; until then,
its highlight groups link to Neovim's standard groups so the colorscheme can be
loaded and its integrations can be developed without choosing colors.

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "thecodecafe/terminal-theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("terminal-theme")
  end,
}
```

For another plugin manager, install this repository on Neovim's `runtimepath`
and add this to your Neovim configuration:

```lua
vim.cmd.colorscheme("terminal-theme")
```

## Development

The colorscheme entry point is `colors/terminal-theme.lua`. Highlight groups
are organized in `lua/terminal-theme/highlights.lua` by editor UI, syntax,
Treesitter, LSP, and common plugin integrations. Add the palette there when it
is available; plugin groups can then use explicit colors or link to the
appropriate palette groups.

The module can also be reloaded from Lua with:

```lua
require("terminal-theme").load()
```
