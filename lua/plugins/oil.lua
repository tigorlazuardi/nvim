return {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["q"] = "actions.close",
            ["<bs>"] = "actions.parent",
            ["h"] = "actions.parent",
            ["l"] = "actions.select",
            ["gv"] = {
                callback = function()
                    require("oil.actions").select.callback { vertical = true }
                    require("oil.actions").close.callback()
                end,
                desc = "Open the entry in a vertical split and close the Oil window",
                nowait = true,
            },
            ["gs"] = {
                callback = function()
                    require("oil.actions").select.callback { horizontal = true }
                    require("oil.actions").close.callback()
                end,
                desc = "Open the entry in a horizontal split and close the Oil window",
                nowait = true,
            },
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Oil" },
    keys = {
        {
            "-",
            function()
                require("oil").open()
                vim.defer_fn(function()
                    require("oil").open_preview()
                end, 150)
            end,
        },
    },
    enabled = true,
}
