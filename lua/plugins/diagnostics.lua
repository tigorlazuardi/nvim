return {
    {
        "dgagn/diagflow.nvim",
        event = { "LspAttach" },
        opts = {
            scope = "line",
            show_sign = false,
            show_borders = true,
            text_align = "right",
            max_width = 60,
            format = function(diagnostic)
                if diagnostic.source and #diagnostic.source > 0 then
                    return string.format("[%s] %s: %s", diagnostic.source, diagnostic.code, diagnostic.message)
                end
                return diagnostic.message
            end,
        },
        enabled = false,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach", -- Or `LspAttach`
        opts = {
            options = {
                throttle = 0,
                multilines = true,
                enable_on_insert = true,
            },
        },
        config = function(_, opts)
            vim.diagnostic.config { virtual_text = false }
            require("tiny-inline-diagnostic").setup(opts)
        end,
    },
}
