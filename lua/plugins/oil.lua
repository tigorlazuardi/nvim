return {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["q"] = "actions.close",
            ["<bs>"] = "actions.parent",
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Oil" },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    enabled = false,
}
