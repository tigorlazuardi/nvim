return {
    "nvim-lspconfig",
    init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = {
            "gD",
            "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type = 'vsplit' })<cr>",
            desc = "Jump to definitions in vsplit",
        }
        keys[#keys + 1] = {
            "grr",
            "<cmd>Trouble lsp_references focus=true<cr>",
            desc = "Jump to references",
        }
        keys[#keys + 1] = {
            "gri",
            "<cmd>Trouble lsp_implementations focus=true<cr>",
            desc = "Jump to references",
        }
        keys[#keys + 1] = {
            "grt",
            "<cmd>Trouble lsp_type_definitions focus=true<cr>",
            desc = "Jump to references",
        }
        keys[#keys + 1] = {
            "grs",
            "<cmd>Trouble lsp_document_symbols focus=true<cr>",
            desc = "Jump to references",
        }
        keys[#keys + 1] = {
            "<F2>",
            vim.lsp.buf.rename,
            desc = "Rename Symbol",
        }
        keys[#keys + 1] = {
            "<c-k>",
            false,
            mode = { "i" },
        }
        keys[#keys + 1] = {
            "gr",
            false,
        }
    end,
    opts = {
        servers = {
            templ = {
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            },
            html = {
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            },
            lua_ls = {
                mason = false;
            };
        },
    },
}
