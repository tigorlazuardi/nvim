return {
    "dundalek/lazy-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        prefer_local = true,
        preferred_servers = {
            nix = {
                "nil_ls",
            },
        },
    },
    -- enabled = false,
}
