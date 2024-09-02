return {
    "dundalek/lazy-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        prefer_local = true,
        excluded_servers = {
            "gopls", -- gopls likes to be double attached if enabled here.
            "bazelrc-lsp",
        },
        preferred_servers = {
            gitcommit = {},
            sql = {},
            nix = {
                "nil_ls",
            },
            typescript = {
                "tsserver",
            },
            proto = {
                "buf-language-server",
            },
            sh = {},
            markdown = {},
        },
    },
    -- enabled = false,
}
