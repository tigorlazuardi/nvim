-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt = vim.opt

opt.shiftwidth = 4
opt.tabstop = 4

-- vim.api.nvim_create_autocmd("BufReadPost", {
--     group = vim.api.nvim_create_augroup("LazyVim_AutoUpdate", {}),
--     once = true,
--     callback = function()
--         require("lazy").update {
--             show = false,
--             wait = false,
--             concurrency = 4,
--         }
--     end,
-- })

-- Golang templ filetype
vim.filetype.add {
    extension = {
        templ = "templ",
        gotmpl = "gotmpl",
    },
}
