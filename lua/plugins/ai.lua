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
    -- {
    --     "milanglacier/minuet-ai.nvim",
    --     init = load_api_keys,
    --     opts = {
    --         virtualtext = {
    --             auto_trigger_ft = { "*" },
    --             keymap = {
    --                 accept = "<a-y>",
    --             },
    --         },
    --         provider = "gemini",
    --         provider_options = {
    --             gemini = {
    --                 optional = {
    --                     generationConfig = {
    --                         maxOutputTokens = 256,
    --                     },
    --                     safetySettings = {
    --                         {
    --                             -- HARM_CATEGORY_HATE_SPEECH,
    --                             -- HARM_CATEGORY_HARASSMENT
    --                             -- HARM_CATEGORY_SEXUALLY_EXPLICIT
    --                             category = "HARM_CATEGORY_DANGEROUS_CONTENT",
    --                             -- BLOCK_NONE
    --                             threshold = "BLOCK_ONLY_HIGH",
    --                         },
    --                     },
    --                 },
    --             },
    --         },
    --     },
    -- },
    {
        "blink.cmp",
        opts = function(_, opts)
            if pcall(require, "codecompanion") then
                opts = vim.tbl_deep_extend("force", opts or {}, {
                    sources = {
                        per_filetype = {
                            codecompanion = { "codecompanion" },
                        },
                    },
                })
            end
            return opts
        end,
    },
}
