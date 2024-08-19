-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require "config.neovide"

vim.keymap.set("t", "<c-d>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

if vim.fn.executable "lazygit" == 1 then
    require "config.lazygit"
end

if vim.env.HYPRLAND_INSTANCE_SIGNATURE ~= nil and vim.fn.executable "footclient" == 1 then
    require "config.terminal"
end
