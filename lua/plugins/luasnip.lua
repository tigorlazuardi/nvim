return {
    {
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            require "snippets"
            return opts
        end,
    },
    {
        "nvim-cmp",
        keys = {
            {
                "<tab>",
                false,
                mode = "i",
            },
            {
                "<c-j>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<c-j>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
            {
                "<c-k>",
                function()
                    return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<c-k>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<s-tab>",
                false,
                mode = { "i" },
            },
        },
    },
}
