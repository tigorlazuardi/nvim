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
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "xmlformatter" })
        end,
    },
    {
        -- Add lombok support
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            local lombok_jar_path = (vim.fn.expand "$MASON") .. "/packages/jdtls/lombok.jar"
            opts.cmd = {
                vim.fn.exepath "jdtls",
                ([[--jvm-arg=-javaagent:%s]]):format(lombok_jar_path),
            }
        end,
    },
    { "rcasia/neotest-java", lazy = true },
    {
        "nvim-neotest/neotest",
        opts = function(_, opts)
            opts = opts or {}
            opts.adapters = opts.adapters or {}
            vim.list_extend(opts.adapters, { "neotest-java" })
        end,
    },
}
