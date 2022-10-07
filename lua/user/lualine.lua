local is_linux = require('common').is_linux

local function separators()
  if is_linux() or vim.g.neovide then return nil else return { left = '', right = '' } end
end

require('lualine').setup {
  options = {
    globalstatus = true,
    section_separators = separators(),
    component_separators = separators(),
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
