return {
    "sopa0/telescope-makefile",
    dependencies = {
        "akinsho/toggleterm.nvim",
    },
    cmd = { "Make" },
    keys = {
        { "<leader>m", "<cmd>Telescope make<cr>", { desc = "Launch Make Items" } },
    },
    config = function()
        require("telescope").load_extension "make"
        vim.api.nvim_create_user_command("Make", [[Telescope make]], {})
    end,
}
