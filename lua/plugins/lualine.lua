require("lualine").setup({
  options = {
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
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_x = {},
  },
  extensions = { "fugitive", "quickfix" },
  tabline = {
    lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
