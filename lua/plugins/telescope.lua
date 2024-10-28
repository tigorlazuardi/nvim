return {
    {
        "danielfalk/smart-open.nvim",
        keys = {
            {
                "<leader><space>",
                function()
                    require("telescope").extensions.smart_open.smart_open { cwd_only = true }
                end,
                desc = "Open file or buffers",
            },
        },
    },
    {
        "telescope.nvim",
        opts = {
            extensions = {
                smart_open = {
                    result_limit = 50,
                },
            },
        },
        keys = {
            {
                "<leader><space>",
                false,
            },
        },
    },
}
