return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        opts = {
            preset = "powerline",
            options = {
                show_source = true,
                throttle = 0,
                multilines = {
                    enabled = true,
                    always_show = true,
                },
                multiple_diag_under_cursor = true,
                enable_on_insert = true,
            },
        },
        init = function()
            vim.diagnostic.config { virtual_text = false }
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("TiniInlineDiagnosticDisableVText", {}),
                callback = function()
                    vim.diagnostic.config { virtual_text = false }
                end,
            })
        end,
    },
}
