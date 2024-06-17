return {
    {
        "rktjmp/fwatch.nvim",
        dependencies = {
            "xiyaowong/transparent.nvim", -- For Transparency support
            { "echasnovski/mini.nvim", version = false },
        },
        lazy = false,
        config = function()
            local fwatch = require "fwatch"

            local color_file = vim.fn.getenv "HOME" .. "/.cache/wallust/base16-nvim.lua"
            local error_fn = function(err)
                vim.notify("Watch Error: " .. err, vim.log.levels.ERROR, { title = "fwatch.nvim" })
            end
            local command = {}
            local source_fn = function(_, _, unwatch)
                vim.schedule(function()
                    if vim.fn.filereadable(color_file) == 1 then
                        vim.cmd(("source %s"):format(color_file))
                        if not vim.g.neovide then
                            require("transparent").setup {
                                groups = {
                                    "Normal",
                                    "NormalNC",
                                    "Comment",
                                    "Constant",
                                    "Special",
                                    "Identifier",
                                    "Statement",
                                    "PreProc",
                                    "Type",
                                    "Underlined",
                                    "Todo",
                                    "String",
                                    "Function",
                                    "Conditional",
                                    "Repeat",
                                    "Operator",
                                    "Structure",
                                    "LineNr",
                                    "NonText",
                                    "SignColumn",
                                    -- "CursorLine",
                                    -- "CursorLineNr",
                                    "StatusLine",
                                    "StatusLineNC",
                                    "EndOfBuffer",
                                },
                            }
                        end
                        if unwatch then
                            unwatch()
                        end
                        fwatch.watch(color_file, command)
                    end
                end)
            end
            command.on_event = source_fn
            command.on_error = error_fn
            source_fn()
            fwatch.watch(color_file, command)
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {},
        event = "VeryLazy",
    },
}
