return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    setup = function()
        if vim.fn.executable "nvr" == 1 then
            vim.env.GIT_EDITOR = [[nvr -cc split --remote-wait +'set bufhidden=wipe']]
        end
    end,
    enabled = false,
    keys = {
        { "<leader>z", "<cmd>LazyGit<cr>", desc = "Symbols Outline" },
    },
}
