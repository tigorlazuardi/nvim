return {
    "bloznelis/before.nvim",
    opts = {},
    event = { "InsertEnter" },
    keys = {
        { "<C-h>", "<cmd>lua require'before'.jump_to_last_edit()<CR>", desc = "Jump to last edit" },
        { "<C-l>", "<cmd>lua require'before'.jump_to_next_edit()<CR>", desc = "Jump to next edit" },
    },
}
