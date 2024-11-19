return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
        },
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        cmd = { "AdvancedGitSearch" },
        keys = {
            { "ghh", "<cmd>AdvancedGitSearch search_log_content_file<cr>", desc = "Git File History" },
            { "gh", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced Git Search" },
            { "ghH", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced Git Search" },
            {
                "ghl",
                "<cmd>AdvancedGitSearch diff_commit_line<cr>",
                desc = "Search Commits affecting line",
                mode = { "v" },
            },
        },
        init = function()
            require("telescope").load_extension "advanced_git_search"
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- to show diff splits and open commits in browser
            "tpope/vim-fugitive",
            -- to open commits in browser with fugitive
            "tpope/vim-rhubarb",
            -- optional: to replace the diff from fugitive with diffview.nvim
            -- (fugitive is still needed to open in browser)
            "sindrets/diffview.nvim",
        },
    },
    {
        "telescope.nvim",
        opts = {
            extensions = {
                advanced_git_search = {},
            },
        },
    },
}
