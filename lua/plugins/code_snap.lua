return {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = {
        "CodeSnap",
        "CodeSnapSave",
        "CodeSnapHighlight",
        "CodeSnapSaveHighlight",
        "CodeSnapASCII",
    },
    opts = {
        mac_window_bar = false,
        save_path = "~/Pictures",
        watermark = "",
        has_breadcrumbs = true,
        has_line_number = true,
        code_font_family = "JetBrainsMono Nerd Font",
        bg_x_padding = 20,
        bg_y_padding = 20,
    },
}
