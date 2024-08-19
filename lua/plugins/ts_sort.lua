return {
    "mtrajano/tssorter.nvim",
    cmd = { "TSSort", "Sort" },
    opts = function()
        vim.api.nvim_create_user_command("Sort", "TSSort", {
            desc = "Alias for TSSort. Sorts the treesitter nodes (keys, strings, list, etc) under the cursor while keeping the structure of the node.",
        })
        return {}
    end, -- latest stable version, use `main` to keep up with the latest changes
    version = false,
}
