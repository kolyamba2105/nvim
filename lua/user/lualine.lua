local common = require('common')

local function separators()
  if common.is_linux() then return nil else return { left = '', right = '' } end
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
