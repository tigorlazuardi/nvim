return {
    -- Add cursor text objects. Using `[` and `]` to move the cursor to the start and end of the text object.
    --
    -- d[a} - Delete around the start of a {}-pair to the cursor.
    -- d]a} - Delete around the cursor to the end of a {}-pair.
    -- gc[ip - Comment from the start of the paragraph to the cursor.
    -- gc]ip - Comment from the cursor to the end of the paragraph.
    -- gw[ip - Format from the start of the paragraph to the cursor.
    -- gw]ip - Format from the cursor to the end of the paragraph.
    -- v[ip - Select from the start of the paragraph to the cursor.
    -- v]ip - Select from the cursor to the end of the paragraph.
    -- y[ib - Yank inside start of a ()-pair to the cursor.
    -- y]ib - Yank inside the cursor to the end of a ()-pair.
    {
        "ColinKennedy/cursor-text-objects.nvim",
        init = function()
            vim.keymap.set(
                { "o", "x" },
                "[",
                "<Plug>(cursor-text-objects-up)",
                { desc = "Run from your current cursor to the end of the text-object." }
            )
            vim.keymap.set(
                { "o", "x" },
                "]",
                "<Plug>(cursor-text-objects-down)",
                { desc = "Run from your current cursor to the end of the text-object." }
            )
        end,
        version = "v1.*",
    },
}
