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
    opts = {
        keybindings = {
            ["<ESC>"] = "q",
            -- Override the open mode (i.e. vertical/horizontal split, new tab)
            -- Tip: you can add an extra `<CR>` to the end of these to immediately open the selected file(s) (assuming the TFM uses `enter` to finalise selection)
            ["<C-v>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR><CR>",
            ["<C-x>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR><CR>",
            ["<C-t>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR><CR>",
        },
    },
    enabled = false,
}
