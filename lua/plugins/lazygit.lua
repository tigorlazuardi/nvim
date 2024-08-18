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
    enabled = (not vim.fn.executable "zellij" == 1) and (not vim.fn.executable "footclient" == 1),
    keys = {
        { "<leader>z", "<cmd>LazyGit<cr>", desc = "Symbols Outline" },
    },
}
