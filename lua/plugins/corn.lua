return {
    "RaafatTurki/corn.nvim",
    event = { "LspAttach" },
    opts = {
        border_style = "rounded",
        icons = {
            error = " ",
            warn = " ",
            hint = " ",
            info = " ",
        },
        item_preprocess_func = function(item)
            return item
        end,
    },
    config = function(_, opts)
        vim.diagnostic.config { virtual_text = false }
        require("corn").setup(opts)
    end,
    enabled = false,
}
