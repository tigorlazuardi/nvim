local function load_api_keys()
    if vim.env.GEMINI_API_KEY == nil then
        local gemini_api_key = assert(vim.env.GEMINI_API_KEY_FILE, "Gemini api key file should be set in env")
        local file, err = io.open(gemini_api_key, "r")
        assert(file, err)
        vim.env.GEMINI_API_KEY = file:read "*a"
        io.close(file)
    end
end

return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        init = load_api_keys,
        opts = {
            strategies = {
                chat = {
                    adapter = vim.env.OLLAMA_CODE_INSTRUCTION_MODEL ~= nil and "ollama" or "copilot",
                },
                inline = {
                    adapter = vim.env.OLLAMA_CODE_INSTRUCTION_MODEL ~= nil and "ollama" or "copilot",
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
                ollama = function()
                    local model = assert(vim.env.OLLAMA_CODE_INSTRUCTION_MODEL)
                    return require("codecompanion.adapters").extend("ollama", {
                        name = model,
                        schema = {
                            model = {
                                default = model,
                            },
                            num_ctx = { default = 1024 * 8 },
                            num_predict = {
                                default = -1,
                            },
                        },
                    })
                end,
            },
        },
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
