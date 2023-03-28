return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            component_separators = { left = "", right = "" },
            globalstatus = true,
            refresh = {
                statusline = 500,
                tabline = 500,
            },
            theme = "catppuccin",
        },
        sections = {
            lualine_b = {
                { "branch" },
                { "diff" },
            },
            lualine_c = {
                { "filename" },
                { "diagnostics", sources = { "nvim_diagnostic" } },
            },
            lualine_x = {},
        },
        extensions = {
            "fugitive",
            "quickfix",
        },
    },
}
