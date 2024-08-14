-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require "config.neovide"

vim.keymap.set("t", "<c-d>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

vim.keymap.set(
    "n",
    "<leader>z",
    function()
        local cwd = vim.fn.expand "%:p:h"
        vim.system {
            "hyprctl",
            "dispatch",
            "exec",
            "--",
            "foot",
            "--app-id=lazygit",
            "--title=lazygit",
            "--working-directory=" .. cwd,
            "--",
            "lazygit",
        }
    end,
    -- [[<cmd>silent !foot --app-id=lazygit --working-directory=. -- lazygit<cr>]],
    { desc = "Open Lazygit" }
)

vim.keymap.set("n", "<F5>", [[<cmd>silent !footclient --no-wait<cr>]], { desc = "Open New terminal" })
