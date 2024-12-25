return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        dependencies = {
            "xiyaowong/transparent.nvim", -- For Transparency support
        },
        opts = {
            styles = {
                functions = { "italic" },
                keywords = { "italic" },
            },
            transparent_background = true,
        },
        config = function(opts)
            require("catppuccin").setup(opts)
            vim.g.neovide_transparency = 0.7
            vim.g.transparency = 0.8
            vim.g.neovide_window_blurred = true
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
                        -- "StatusLine",
                        -- "StatusLineNC",
                        "EndOfBuffer",
                    },
                }
            end
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
