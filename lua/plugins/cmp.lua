return {
    {
        "hrsh7th/cmp-path",
        enabled = false,
    },
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "https://codeberg.org/FelipeLema/cmp-async-path.git",
            -- "hrsh7th/cmp-nvim-lsp-signature-help",
            { "lukas-reineke/cmp-rg", enabled = vim.fn.exepath "rg" ~= "" },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        opts = function(_, opts)
            local cmp = require "cmp"
            table.insert(opts.sources, 3, { name = "async_path" })
            opts.window = {
                completion = cmp.config.window.bordered(),
            }

            if vim.fn.exepath "rg" ~= "" then
                table.insert(opts.sources, 4, { name = "rg" })
            end

            opts.preselect = cmp.PreselectMode.None

            opts.mapping = cmp.mapping.preset.insert {
                ["<cr>"] = function(fallback)
                    cmp.abort()
                    fallback()
                end,
                ["<c-cr>"] = cmp.mapping.confirm { select = true },
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<S-CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }

            ---@diagnostic disable-next-line: missing-fields
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = "async_path" },
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                },
            })

            ---@diagnostic disable-next-line: missing-fields
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = "nvim_lsp_document_symbol" },
                    { name = "buffer" },
                },
            })

            return opts
        end,
    },
}
