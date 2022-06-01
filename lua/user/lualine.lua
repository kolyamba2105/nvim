local lualine = require('lualine')

local setup_config = function()
  local empty_sep = { left = '', right = '' }

  local config = {
    options = {
      globalstatus = true,
      section_separators = empty_sep,
      component_separators = empty_sep,
      theme = 'gruvbox-material',
    },
    sections = {
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
    }
  }

  table.insert(config.sections.lualine_b, { 'branch' })
  table.insert(config.sections.lualine_b, { 'diff' })
  table.insert(config.sections.lualine_c, { 'filename' })
  table.insert(config.sections.lualine_c, { 'diagnostics', sources = { 'nvim_diagnostic' } })

  return config
end

lualine.setup(setup_config())
