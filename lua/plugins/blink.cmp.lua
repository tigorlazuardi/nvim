return {
    "blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        snippets = { preset = "luasnip" },
        completion = {
            documentation = {
                window = {
                    border = "rounded",
                },
            },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description" },
                        { "kind" },
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local miniIcons = require "mini.icons"
                                if ctx.kind == "Folder" then
                                    return miniIcons.get("directory", ctx.label)
                                end
                                if ctx.kind == "File" then
                                    return miniIcons.get("file", ctx.label)
                                end
                                if ctx.kind == "Copilot" then
                                    return ""
                                end
                                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,
                            -- Optionally, you may also use the highlights from mini.icons
                            highlight = function(ctx)
                                if ctx.kind == "Folder" then
                                    local _, hl, _ = require("mini.icons").get("directory", ctx.label)
                                    return hl
                                end
                                if ctx.kind == "File" then
                                    local _, hl, _ = require("mini.icons").get("file", ctx.label)
                                    return hl
                                end
                                if ctx.kind == "Copilot" then
                                    local _, hl, _ = require("mini.icons").get("os", "nixos")
                                    return hl
                                end
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            text = function(ctx)
                                return " " .. ctx.kind
                            end,
                        },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            cmdline = function()
                local type = vim.fn.getcmdtype()
                -- Search forward and backward
                if type == "/" or type == "?" then
                    return { "buffer" }
                end
                -- Commands
                if type == ":" then
                    return { "cmdline" }
                end
                return {}
            end,
        },
        keymap = {
            preset = "default",
        },
    },
}
