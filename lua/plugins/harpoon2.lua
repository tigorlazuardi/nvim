return {
    "ThePrimeagen/harpoon",
    keys = function()
        local keys = {
            {
                "<leader>H",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon File",
            },
            {
                "<leader>h",
                function()
                    local harpoon = require "harpoon"
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Quick Menu",
            },
        }
        for i = 1, 5 do
            table.insert(keys, {
                tostring(i),
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon to File " .. i,
            })
        end
        return keys
    end,
}
