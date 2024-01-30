local string_utils = require("utils.string")

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            component_separators = {
                left = nil,
                right = nil,
            },
            globalstatus = true,
            refresh = {
                statusline = 500,
                tabline = 500,
            },
            theme = "catppuccin",
        },
        sections = {
            lualine_a = {
                { "mode", fmt = string_utils.capitalize, icon = "" },
            },
            lualine_b = {
                { "branch", icon = "" },
                { "diff" },
            },
            lualine_c = {
                { "filename", icon = "", path = 3 },
                { "diagnostics", sources = { "nvim_diagnostic" } },
            },
            lualine_x = { "filetype" },
        },
        extensions = {
            "fugitive",
            "quickfix",
        },
    },
}
