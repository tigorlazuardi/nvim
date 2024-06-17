local function workspace(name)
    return {
        name = name,
        path = ("%s/Obsidian/%s"):format(vim.env.HOME, name),
    }
end

local function event(name)
    return ("%s %s/Obsidian/**.md"):format(name, vim.env.HOME)
end

return {
    "epwalsh/obsidian.nvim",
    cmd = {
        "ObsidianOpen",
        "ObsidianNew",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianWorkspace",
        "ObsidianSearch",
        "ObsidianQuickSwitch",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    event = {
        event "BufReadPre",
        event "BufNewFile",
    },
    opts = {
        workspaces = {
            workspace "personal",
            workspace "work",
            workspace "stories",
            workspace "tigor",
        },
        mappings = {},
    },
    config = function(_, opts)
        require("obsidian").setup(opts)

        vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gf"
            end
        end, { noremap = false, expr = true, desc = "Obsidian Follow Link or Fallback" })
    end,
}
