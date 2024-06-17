return {
    "tigorlazuardi/silicon.lua",
    cmd = { "Silicon" },
    config = function()
        require("silicon").setup {
            output = function()
                return ([[%s/Pictures/SILICON_%s.png]]):format(vim.env.HOME, os.date "%Y-%m-%d_%H-%M-%S")
            end,
            padHoriz = 40,
            padVert = 50,
        }
        vim.api.nvim_create_user_command("Silicon", function(ctx)
            local args = (ctx.fargs or {})[1]
            local opts = {}
            if args == "buffer" then
                opts.show_buf = true
            end
            if args == "visible" then
                opts.visible = true
            end
            if not ctx.bang then
                opts.to_clip = true
            end
            require("silicon").visualise_cmdline(opts)
        end, {
            range = 2,
            desc = "Create screenshot from given range. Add Bang (!) at the end of the command to save to file instead of clipboard",
            bang = true,
            nargs = "?",
            complete = function(arg)
                if not arg then
                    return { "buffer", "visible" }
                end
                if arg:gsub(" ", "") == "" then
                    return { "buffer", "visible" }
                end
                if string.find("buffer", arg) then
                    return { "buffer" }
                end
                if string.find("visible", arg) then
                    return { "visible" }
                end
                return {}
            end,
        })
        vim.api.nvim_create_autocmd({ "ColorScheme" }, {
            group = vim.api.nvim_create_augroup("SiliconRefresh", {}),
            callback = function()
                local silicon_utils = require "silicon.utils"
                silicon_utils.build_tmTheme()
                silicon_utils.reload_silicon_cache { async = true }
            end,
            desc = "Reload silicon themes cache on colorscheme switch",
        })
    end,
}
