return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "nix",
                "css",
                "bash",
                "hyprlang",
            },
        },
    },
    {
        "nvim-lspconfig",
        opts = {
            servers = {
                nixd = {
                    settings = {
                        nixd = {
                            nixpkgs = {
                                expr = "import <nixpkgs> {}",
                            },
                            options = {
                                nixos = {
                                    expr = (function()
                                        local flake_path = vim.fn.expand "$HOME/dotfiles"
                                        local handle = io.popen "hostname"
                                        local hostname = handle:read "*a"
                                        handle:close()
                                        hostname = string.gsub(hostname, "\n", "")
                                        local expr = [[(builtins.getFlake "%s").nixosConfigurations.%s.options]]
                                        return string.format(expr, flake_path, hostname)
                                    end)(),
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "dundalek/lazy-lsp.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {
            prefer_local = true,
            excluded_servers = {
                "gopls", -- gopls likes to be double attached if enabled here.
                "bazelrc-lsp",
                "nil_ls",
            },
            preferred_servers = {
                gitcommit = {},
                sql = {},
                nix = {
                    -- "nil_ls",
                    "nixd",
                },
                typescript = {
                    "tsserver",
                },
                proto = {
                    "buf-language-server",
                },
                sh = {},
                markdown = {},
            },
        },
    },
}
