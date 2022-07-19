local lualine = require('lualine')
local common = require('user.common')

local setup_config = function()
  local function separators()
    local empty_sep = { left = '', right = '' }

    if common.is_linux() then
      return nil
    else
      return empty_sep
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

lualine.setup(setup_config())
