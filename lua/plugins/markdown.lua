return {
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup {}
        end,
    },
    {
        "toppair/peek.nvim",
        ft = { "markdown" },
        cmd = { "Peek" },
        build = "deno task --quiet build:fast",
        opts = function()
            vim.api.nvim_create_autocmd("FileType", {
                desc = "Create peek command on markdown ft",
                pattern = "markdown",
                callback = function(ev)
                    vim.api.nvim_buf_create_user_command(ev.buf, "Peek", function(ctx)
                        local peek = require "peek"
                        if peek.is_open() then
                            if ctx.bang then
                                peek.close()
                            end
                            return
                        end
                        peek.open()
                    end, { bang = true })
                end,
            })
            return {
                app = { "chromium", "--new-window" },
            }
        end,
    },
}
