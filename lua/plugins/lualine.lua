local string_utils = require("utils.string")

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
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
                    { "mode", fmt = string_utils.capitalize, icon = "" },
                },
                lualine_b = {
                    { "branch", icon = "" },
                    { "diff" },
                    { "diagnostics", sources = { "nvim_diagnostic" } },
                },
                lualine_c = {
                    "filename",
                },
                lualine_x = {
                    "filetype",
                },
            },
            extensions = {
                "fugitive",
                "quickfix",
            },
        })
    end,
    enabled = true,
}
