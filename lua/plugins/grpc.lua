return {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Grpc" },
    init = function()
        vim.filetype.add { extension = { grpc = "grpc" } }
        vim.treesitter.language.register("bash", "grpc")
    end,
}
