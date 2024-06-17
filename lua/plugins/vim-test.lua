return {
    "vim-test/vim-test",
    keys = {
        { "<leader>Tr", "<cmd>TestNearest<cr>", desc = "Test Run Nearest" },
        { "<leader>Tt", "<cmd>TestFile<cr>", desc = "Test File" },
        { "<leader>TT", "<cmd>TestSuite<cr>", desc = "Test All Files" },
        { "<leader>Tl", "<cmd>TestLast<cr>", desc = "Test Last" },
        { "<leader>Tg", "<cmd>TestVisit<cr>", desc = "Test Visit" },
    },
}
