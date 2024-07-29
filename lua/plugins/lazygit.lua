return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    enabled = false,
    keys = {
        { "<leader>z", "<cmd>LazyGit<cr>", desc = "Symbols Outline" },
    },
}
