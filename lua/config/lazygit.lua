if vim.env.ZELLIJ ~= nil and not vim.g.neovide then
    -- currently running inside zellij session and not inside neovide
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
elseif vim.env.HYPRLAND_INSTANCE_SIGNATURE ~= nil and vim.fn.executable "foot" == 1 then
    vim.keymap.set("n", "<leader>z", function()
        vim.system {
            "hyprctl",
            "dispatch",
            "exec",
            "--",
            "foot",
            "--app-id=lazygit",
            "--title=lazygit",
            "--working-directory=" .. vim.fn.getcwd(),
            "--",
            "lazygit",
        }
    end, { desc = "Open Lazygit (Foot)" })
end
