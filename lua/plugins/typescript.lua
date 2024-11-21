return {
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        ft = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript.tsx",
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                vtsls = { enabled = false },
                tsserver = { enabled = false },
                ts_ls = { enabled = false },
            },
        },
    },
}
