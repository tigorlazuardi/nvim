local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup {
    git = {
        throttle = {
            enabled = true,
            rate = 4,
            duration = 2000,
        },
    },
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import any extras modules here
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.ai.copilot" },
        { import = "lazyvim.plugins.extras.ai.copilot-chat" },
        { import = "lazyvim.plugins.extras.coding.yanky" },
        -- { import = "lazyvim.plugins.extras.coding.luasnip" },
        { import = "lazyvim.plugins.extras.coding.mini-surround" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },

        { import = "lazyvim.plugins.extras.dap.core" },
        { import = "lazyvim.plugins.extras.dap.nlua" },
        { import = "lazyvim.plugins.extras.test.core" },
        { import = "lazyvim.plugins.extras.lang.docker" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.yaml" },
        { import = "lazyvim.plugins.extras.lsp.none-ls" },
        -- { import = "lazyvim.plugins.extras.editor.mini-files" },
        -- { import = "lazyvim.plugins.extras.ui.edgy" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = false }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

require("lazyvim.util").get_root = vim.loop.cwd
