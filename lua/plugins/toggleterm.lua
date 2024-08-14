return {
    enabled = false,
    "akinsho/toggleterm.nvim",
    keys = {
        { "<F5>", "Open Toggleterm" },
    },
    cmd = { "ToggleTerm" },
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                if vim.o.lines < 60 then
                    return 12
                end
                return 20
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.3
            end
        end,
        open_mapping = [[<F5>]],
    },
}
