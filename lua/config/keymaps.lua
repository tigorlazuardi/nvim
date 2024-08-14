-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require "config.neovide"

vim.keymap.set("t", "<c-d>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

vim.keymap.set(
    "n",
    "<leader>z",
    "<cmd>silent !wezterm start --class lazygit --cwd . -- lazygit<cr>",
    { desc = "Open Lazygit" }
)
