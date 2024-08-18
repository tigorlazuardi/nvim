-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require "config.neovide"

vim.keymap.set("t", "<c-d>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

if vim.env.ZELLIJ ~= nil then
    vim.keymap.set("n", "<leader>z", function()
        local cwd = vim.fn.expand "%:p:h"
        vim.system {
            "zellij",
            "run",
            "--close-on-exit",
            "--cwd",
            cwd,
            "--in-place",
            "--",
            "lazygit",
        }
    end, { desc = "Open Lazygit (Zellij)" })
elseif vim.fn.executable "hyprctl" == 1 and vim.fn.executable "footclient" == 1 then
    vim.keymap.set("n", "<leader>z", function()
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
    end, { desc = "Open Lazygit (Foot)" })
end

vim.keymap.set("n", "<F5>", [[<cmd>silent !footclient --no-wait<cr>]], { desc = "Open New terminal" })
