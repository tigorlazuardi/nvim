return {
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
        event = "BufEnter",
        enabled = not vim.g.neovide,
    },
    {
        "karb94/neoscroll.nvim",
        event = "BufEnter",
        opts = {},
        enabled = not vim.g.neovide,
    },
}
