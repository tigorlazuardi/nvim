return {
    "dundalek/lazy-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        excluded_servers = { "jdtls", "gopls", "tsserver" },
    },
    enabled = false,
}
