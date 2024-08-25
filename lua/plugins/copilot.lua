return {
    {
        "zbirenbaum/copilot.lua",
        event = { "InsertEnter" },
        opts = {
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<M-h>",
                },
            },
            filetypes = {
                ["*"] = true,
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        enabled = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
