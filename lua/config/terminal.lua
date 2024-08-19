local session_id = math.random(1, 100000)
local app_id = ([[neovim-terminal-%d]]):format(session_id)
local class = ([[class:%s]]):format(app_id)

vim.keymap.set("n", "<F5>", function()
    vim.system({ "hyprctl", "clients", "-j" }, { text = true }, function(output)
        for _, client in ipairs(vim.json.decode(output.stdout)) do
            if client.class == app_id then
                -- focus instead of open new
                vim.system { "hyprctl", "dispatch", "focuswindow", class }
                return
            end
        end
        vim.schedule(function()
            vim.system({
                "hyprctl",
                "dispatch",
                "exec",
                "--",
                "footclient",
                "--working-directory",
                vim.fn.getcwd(),
                "--app-id",
                app_id,
                "--title=neovim-terminal",
            }, {}, function()
                vim.defer_fn(function()
                    vim.system {
                        "hyprctl",
                        "dispatch",
                        "resizewindowpixel",
                        ([[exact 80%% 100%%,%s]]):format(class),
                    }
                end, 50)
            end)
            vim.api.nvim_create_autocmd("VimLeave", {
                pattern = "*",
                callback = function()
                    vim.system { "hyprctl", "dispatch", "closewindow", class }
                end,
            })
        end)
    end)
end, { desc = "Open New terminal" })
