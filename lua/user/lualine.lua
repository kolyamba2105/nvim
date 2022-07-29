local common = require('common')

local setup_config = function()
  local function separators()
    if common.is_linux() then
      return nil
    else
      return { left = '', right = '' }
    end
  end

  local config = {
    options = {
      globalstatus = true,
      section_separators = separators(),
      component_separators = separators(),
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

require('lualine').setup(setup_config())
