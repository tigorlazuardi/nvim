return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
            },
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = {
                            api_key = ([[cmd:cat %s]]):format(
                                assert(os.getenv "GEMINI_API_KEY_FILE", "Gemini api key file should be set in env")
                            ),
                        },
                    })
                end,
            },
        },
        cond = function()
            return os.getenv "GEMINI_API_KEY_FILE" ~= nil
        end,
    },
    {
        "blink.cmp",
        opts = {
            sources = {
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
            },
        },
    },
}
