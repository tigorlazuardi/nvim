return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "RRethy/nvim-treesitter-endwise",
        },
        opts = {
            endwise = {
                enable = true,
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            filetypes = {
                "astro",
                "glimmer",
                "handlebars",
                "hbs",
                "html",
                "javascript",
                "javascriptreact",
                "jsx",
                "markdown",
                "php",
                "rescript",
                "svelte",
                "templ",
                "tsx",
                "typescript",
                "typescriptreact",
                "vue",
                "xml",
            },
        },
    },
}
