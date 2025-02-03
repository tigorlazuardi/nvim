return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            indent = { disable = { "go" } },
        },
    },
    {
        "maxandron/goplements.nvim",
        ft = "go",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    settings = {
                        gopls = {
                            staticcheck = false,
                            analyses = {
                                fieldalignment = false,
                            },
                            usePlaceholders = false,
                            hints = {
                                assignVariableTypes = false,
                                compositeLiteralFields = false,
                                compositeLiteralTypes = false,
                                constantValues = false,
                                functionTypeParameters = false,
                                parameterNames = false,
                                rangeVariableTypes = false,
                            },
                        },
                    },
                },
            },
            -- setup = {
            --     gopls = function(_, opts)
            --         require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            --             if client.name == "gopls" then
            --                 -- workaround for gopls not supporting semanticTokensProvider
            --                 -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            --                 if not client.server_capabilities.semanticTokensProvider then
            --                     local semantic = client.config.capabilities.textDocument.semanticTokens
            --                     client.server_capabilities.semanticTokensProvider = {
            --                         full = true,
            --                         legend = {
            --                             tokenTypes = semantic.tokenTypes,
            --                             tokenModifiers = semantic.tokenModifiers,
            --                         },
            --                         range = true,
            --                     }
            --                 end
            --                 -- end workaround
            --
            --                 -- run lsp imports code action on save.
            --                 vim.api.nvim_create_autocmd("BufWritePre", {
            --                     desc = "Auto format and organize imports on save (gopls)",
            --                     group = vim.api.nvim_create_augroup("GoplsAutoFormat", {}),
            --                     buffer = bufnr,
            --                     callback = function(event)
            --                         local context = { source = { organizeImports = true } }
            --                         local params = vim.lsp.util.make_range_params()
            --                         params.context = context
            --                         local result =
            --                             vim.lsp.buf_request_sync(event.buf, "textDocument/codeAction", params, 3000)
            --                         if not result then
            --                             return
            --                         end
            --                         if not result[1] then
            --                             return
            --                         end
            --                         result = result[1].result
            --                         if not result then
            --                             return
            --                         end
            --                         if not result[1] then
            --                             return
            --                         end
            --                         local edit = result[1].edit
            --                         if not edit then
            --                             return
            --                         end
            --                         vim.lsp.util.apply_workspace_edit(edit, "utf-8")
            --                     end,
            --                 })
            --             end
            --         end)
            --     end,
            -- },
        },
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "edolphin-ydf/goimpl.nvim",
        ft = "go",
        config = function()
            require("telescope").load_extension "goimpl"
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("GoImpl", {}),
                callback = function(ctx)
                    local client = vim.lsp.get_client_by_id(ctx.data.client_id) or {}
                    if client.name == "gopls" then
                        vim.api.nvim_create_user_command("Impl", [[Telescope goimpl]], {})
                        vim.keymap.set(
                            "n",
                            "<leader>ci",
                            [[<cmd>Telescope goimpl<cr>]],
                            { buffer = ctx.buf, desc = "Generate implementation stub" }
                        )
                    end
                end,
            })
        end,
    },
}
