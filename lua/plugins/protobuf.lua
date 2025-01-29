return {
    {
        "conform.nvim",
        opts = {
            formatters_by_ft = {
                proto = { "buf" },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                proto = { "buf_lint" },
            },
        },
    },
}
