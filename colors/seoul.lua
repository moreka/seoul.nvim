--  _____             _
-- |   __|___ ___ _ _| |
-- |__   | -_| . | | | |
-- |_____|___|___|___|_|.nvim
--
-- Low-contrast dark Neovim color scheme using Seoul Colors
-- based on seoul256.vim
--
-- Repo:        https://github.com/moreka/seoul.nvim
-- Author:      Mohammad Reza Karimi
-- License:     MIT
-- Original:    https://github.com/junegunn/seoul256.vim

vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

if vim.g.colors_name then
    vim.g.colors_name = "seoul"
end
vim.o.termguicolors = true
require("seoul").load()
