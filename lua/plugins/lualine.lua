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

vim.api.nvim_create_user_command(
  "ToggleTabline",
  function() vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2 end,
  {}
)
