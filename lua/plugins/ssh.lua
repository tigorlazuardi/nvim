return {
    "ojroques/nvim-osc52",
    cond = vim.env.SSH_CLIENT ~= nil,
    config = function()
        require("osc52").setup({})
        vim.api.nvim_create_autocmd("TextYankPost", {
            callback = function()
                require("osc52").copy(table.concat(vim.v.event.regcontents, "\n"))
            end,
            desc = "Copy to Clipboard from SSH Session",
        })
    end,
}
