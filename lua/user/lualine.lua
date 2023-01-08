require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'gruvbox-material',
  },
  sections = {
    lualine_b = {
      { 'branch' },
      { 'diff' },
    },
    lualine_c = {
      { 'filename' },
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_x = {},
  }
}
