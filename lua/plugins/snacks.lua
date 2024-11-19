return {
    "folke/snacks.nvim",
    keys = {
        { "<leader>z", "<cmd>lua Snacks.lazygit()<cr>", desc = "LazyGit" },
        { "<leader>bd", "<cmd>lua Snacks.bufdelete()<cr>", desc = "(Snacks) Delete Buffer" },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
        },
    },
}
