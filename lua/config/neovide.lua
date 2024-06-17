if not vim.g.neovide then
    return
end

local font = "JetBrainsMono Nerd Font Mono"

local font_size = vim.o.lines < 60 and 11 or 12

vim.o.guifont = font .. ":h" .. font_size

vim.keymap.set("n", "<c-->", function()
    font_size = font_size - 1
    vim.o.guifont = font .. ":h" .. font_size
    vim.notify("Font Set: " .. font .. ":h" .. font_size)
end, { desc = "Decrease font size" })

vim.keymap.set("n", "<c-=>", function()
    font_size = font_size + 1
    vim.o.guifont = font .. ":h" .. font_size
    vim.notify("Font Set: " .. font .. ":h" .. font_size)
end, { desc = "Increase font size" })
