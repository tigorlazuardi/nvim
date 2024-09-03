return {
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "8ce94cb53741c5038ceac239372cafd16c8b5a85",
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
