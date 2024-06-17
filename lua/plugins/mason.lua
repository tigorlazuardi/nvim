return {
    "mason.nvim",
    opts = {
        -- NixOS packages should override Mason packages if exist
        PATH = vim.loop.os_uname().version:find("NixOS") and "append" or "prepend",
    },
}
