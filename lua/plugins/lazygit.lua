return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    enabled = vim.fn.exepath("lazygit") ~= "",
    keys = {
        { "<leader>z", "<cmd>LazyGit<cr>", desc = "Symbols Outline" },
    },
}
