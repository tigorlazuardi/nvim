return {
    {
        "echasnovski/mini.files",
        version = false,
        enabled = true,
        opts = {
            windows = {
                preview = true,
                width_preview = 50,
            },
        },
        init = function()
            local map_split = function(buf_id, lhs, direction)
                local mf = require "mini.files"
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    vim.api.nvim_win_call(mf.get_explorer_state().target_window, function()
                        vim.cmd(direction .. " split")
                        new_target_window = vim.api.nvim_get_current_win()
                    end)

                    mf.set_target_window(new_target_window)
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = "Split " .. direction
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local mf = require "mini.files"
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, "gs", "belowright horizontal")
                    map_split(buf_id, "gv", "belowright vertical")
                    vim.keymap.set("n", "<cr>", function()
                        mf.go_in { close_on_file = true }
                    end, { buffer = buf_id, desc = "Open file or directory" })
                end,
            })
        end,
        keys = {
            {
                "-",
                function()
                    local mf = require "mini.files"
                    if not mf.close() then
                        mf.open(vim.api.nvim_buf_get_name(0), false)
                    end
                end,
                desc = "Open/Close mini files from current file directory",
            },
        },
    },
    {
        "folke/snacks.nvim",
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
        end,
    },
}
