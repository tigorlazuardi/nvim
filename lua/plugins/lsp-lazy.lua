return {
    "dundalek/lazy-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        prefer_local = true,
        excluded_servers = {
            "gopls", -- gopls likes to be double attached if enabled here.
        },
        preferred_servers = {
            nix = {
                "nil_ls",
            },
            proto = {
                "buf-language-server",
            },
            sh = {},
        },
    },
    -- enabled = false,
}
