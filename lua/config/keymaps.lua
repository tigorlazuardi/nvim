-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require "config.neovide"

vim.keymap.set("t", "<c-d>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

-- LazyVim hardcode tabs to jump snippet completions. Very fucking annoying.
vim.keymap.del({ "i" }, "<tab>")
vim.keymap.del({ "i" }, "<s-tab>")
