return {
    {
        "nicwest/vim-http",
        ft = "http",
        init = function()
            vim.g.vim_http_tempbuffer = 1
            vim.g.vim_http_clean_before_do = 0
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "http", "json" })
        end,
    },
}
