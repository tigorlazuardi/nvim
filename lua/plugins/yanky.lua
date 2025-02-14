return {
    "gbprod/yanky.nvim",
    dependencies = {
        { "kkharji/sqlite.lua" },
    },
    opts = {
        ring = { storage = "sqlite" },
        highlight = { timer = 150 },
    },
    cond = not vim.g.vscode,
}
