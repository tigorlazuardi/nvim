local java_filetypes = { "java" }

return {
    {
        "conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.xml = { "xmlformat" }

            require("conform").formatters.xmlformat = {
                prepend_args = { "--indent", "1", "--indent-char", "\t" },
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            setup = {
                jdtls = function()
                    return true -- avoid duplicate servers
                end,
            },
        },
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = java_filetypes,
        opts = function()
            return {
                root_dir = LazyVim.lsp.get_raw_config("jdtls").default_config.root_dir,
                project_name = function(root_dir)
                    return root_dir and vim.fs.basename(root_dir)
                end,
                jdtls_config_dir = function(project_name)
                    return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/config"
                end,
                jdtls_workspace_dir = function(project_name)
                    return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/workspace"
                end,
                cmd = {
                    vim.fn.exepath "jdtls",
                    ([[--jvm-arg=-javaagent:%s]]):format(vim.env.LOMBOK_JAR),
                },
                full_cmd = function(opts)
                    local fname = vim.api.nvim_buf_get_name(0)
                    local root_dir = opts.root_dir(fname)
                    local project_name = opts.project_name(root_dir)
                    local cmd = vim.deepcopy(opts.cmd)
                    if project_name then
                        vim.list_extend(cmd, {
                            "-configuration",
                            opts.jdtls_config_dir(project_name),
                            "-data",
                            opts.jdtls_workspace_dir(project_name),
                        })
                    end
                    return cmd
                end,

                -- These depend on nvim-dap, but can additionally be disabled by setting false here.
                dap = { hotcodereplace = "auto", config_overrides = {} },
                dap_main = {},
                test = true,
                settings = {
                    java = {
                        inlayHints = {
                            parameterNames = {
                                enabled = "all",
                            },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local bundles = {} ---@type string[]
            local function attach_jdtls()
                local fname = vim.api.nvim_buf_get_name(0)

                -- Configuration can be augmented and overridden by opts.jdtls
                local config = {
                    cmd = opts.full_cmd(opts),
                    root_dir = opts.root_dir(fname),
                    init_options = {
                        bundles = bundles,
                    },
                    settings = opts.settings,
                    -- enable CMP capabilities
                    capabilities = LazyVim.has "cmp-nvim-lsp" and require("cmp_nvim_lsp").default_capabilities() or nil,
                }

                -- Existing server will be reused if the root_dir matches.
                require("jdtls").start_or_attach(config)
                -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
            end
            vim.api.nvim_create_autocmd("FileType", {
                pattern = java_filetypes,
                callback = attach_jdtls,
            })

            -- Setup keymap and dap after the lsp is fully attached.
            -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
            -- https://neovim.io/doc/user/lsp.html#LspAttach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "jdtls" then
                        local wk = require "which-key"
                        wk.add {
                            {
                                mode = "n",
                                buffer = args.buf,
                                { "<leader>cx", group = "extract" },
                                { "<leader>cxv", require("jdtls").extract_variable_all, desc = "Extract Variable" },
                                { "<leader>cxc", require("jdtls").extract_constant, desc = "Extract Constant" },
                                { "gs", require("jdtls").super_implementation, desc = "Goto Super" },
                                { "gS", require("jdtls.tests").goto_subjects, desc = "Goto Subjects" },
                                { "<leader>co", require("jdtls").organize_imports, desc = "Organize Imports" },
                            },
                        }
                        wk.add {
                            {
                                mode = "v",
                                buffer = args.buf,
                                { "<leader>cx", group = "extract" },
                                {
                                    "<leader>cxm",
                                    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                                    desc = "Extract Method",
                                },
                                {
                                    "<leader>cxv",
                                    [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                                    desc = "Extract Variable",
                                },
                                {
                                    "<leader>cxc",
                                    [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                                    desc = "Extract Constant",
                                },
                            },
                        }

                        -- if opts.dap and LazyVim.has "nvim-dap" and mason_registry.is_installed "java-debug-adapter" then
                        --     -- custom init for Java debugger
                        --     require("jdtls").setup_dap(opts.dap)
                        --     require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
                        --
                        --     -- Java Test require Java debugger to work
                        --     if opts.test and mason_registry.is_installed "java-test" then
                        --         -- custom keymaps for Java test runner (not yet compatible with neotest)
                        --         wk.add {
                        --             {
                        --                 mode = "n",
                        --                 buffer = args.buf,
                        --                 { "<leader>t", group = "test" },
                        --                 {
                        --                     "<leader>tt",
                        --                     function()
                        --                         require("jdtls.dap").test_class {
                        --                             config_overrides = type(opts.test) ~= "boolean"
                        --                                     and opts.test.config_overrides
                        --                                 or nil,
                        --                         }
                        --                     end,
                        --                     desc = "Run All Test",
                        --                 },
                        --                 {
                        --                     "<leader>tr",
                        --                     function()
                        --                         require("jdtls.dap").test_nearest_method {
                        --                             config_overrides = type(opts.test) ~= "boolean"
                        --                                     and opts.test.config_overrides
                        --                                 or nil,
                        --                         }
                        --                     end,
                        --                     desc = "Run Nearest Test",
                        --                 },
                        --                 { "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
                        --             },
                        --         }
                        --     end
                        -- end

                        -- User can set additional keymaps in opts.on_attach
                        if opts.on_attach then
                            opts.on_attach(args)
                        end
                    end
                end,
            })

            -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
            attach_jdtls()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "java" } },
    },
    { "rcasia/neotest-java", lazy = true },
    {
        "nvim-neotest/neotest",
        opts = function(_, opts)
            opts = opts or {}
            opts.adapters = opts.adapters or {}
            vim.list_extend(opts.adapters, { "neotest-java" })
            return opts
        end,
    },
}
