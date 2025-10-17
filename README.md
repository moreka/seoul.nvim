# Seoul.nvim

This aims to be a complete port [seoul256.vim](https://github.com/junegunn/seoul256.vim) with support for lua
plugins, LSP and Treesitter for neovim >= 0.11.
The background and foreground are adjusted to give better contrast.

## Features

- **Low-contrast design** for reduced eye strain during long coding sessions
- **Dark and light variants** controlled by `vim.o.background`
- **Comprehensive syntax highlighting** with modern plugin support:
  - Treesitter highlighting for all major languages
  - LSP diagnostics integration
- **Customizable background darkness** via `dark_offset` and `light_offset` options
- **Terminal colors** properly configured for integrated terminal
- **Custom palette override** support for fine-grained color control

## Installation

### Lazy
```lua
return {
    "moreka/seoul.nvim",
    priority = 1000,
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("seoul")
    end,
}
```

### Packer
```lua
use {
    "moreka/seoul.nvim",
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("seoul")
    end,
}
```

## Configuration

### Basic Configuration

To use the colorscheme with default settings:

```lua
vim.o.background = "dark"  -- or "light"
vim.cmd.colorscheme("seoul")
```

### Advanced Configuration

For custom configuration, call `setup()` before setting the colorscheme:

```lua
require("seoul").setup({
    -- Adjust background for dark colorscheme (default: 0)
    -- Range: -4 to +4 (negative = darker, positive = lighter)
    dark_offset = 0,

    -- Adjust background for light colorscheme (default: 0)
    -- Range: -4 to +4 (negative = darker, positive = lighter)
    light_offset = 0,

    -- Override palette colors (optional)
    palette = {
        dark = {
            -- You can override any color from the default palette
            -- See `lua/seoul/init.lua` for available colors
        },
        light = {
            -- Same for light mode
        },
    },
})

vim.o.background = "dark"
vim.cmd.colorscheme("seoul")
```

## Requirements

- Neovim >= 0.11

## Credits

- Original theme: [seoul256.vim](https://github.com/junegunn/seoul256.vim) by Junegunn Choi
- Port and enhancements: Mohammad Reza Karimi

## License

MIT License - see LICENSE file for details
