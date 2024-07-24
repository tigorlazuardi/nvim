return {
    "nvim-telescope/telescope.nvim",
    keys = {
        { "1", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "2", LazyVim.pick "files", desc = "Find Files (Root Dir)" },
        { "3", LazyVim.pick "live_grep", desc = "Grep (Root Dir)" },
        { "4", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
        { "5", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    },
}
