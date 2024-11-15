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
}
