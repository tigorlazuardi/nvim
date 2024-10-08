return {
    "rolv-apneseth/tfm.nvim",
    keys = {
        {
            "-",
            function()
                require("tfm").open()
            end,
            desc = "Open the default terminal file manager",
        },
    },
}
