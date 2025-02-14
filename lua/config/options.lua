-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable swap files
vim.opt.swapfile = false

vim.defer_fn(function()
    vim.opt.title = true
end, 100)

vim.g.root_spec = { "cwd" }

vim.g.ai_cmp = false

if vim.g.vscode then
    vim.o.cmdheight = 3 -- this is the new line I added
    return
end
