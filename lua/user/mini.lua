require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.cursorword').setup({ delay = 500 })
require('mini.misc').setup()
require('mini.pairs').setup()
require('mini.statusline').setup({
  content = {
    active = function()
      local line = require('mini.statusline')

      local mode, mode_hl = line.section_mode({ trunc_width = 120 })
      local git           = line.section_git({ trunc_width = 75 })
      local diagnostics   = line.section_diagnostics({ trunc_width = 75 })
      local filename      = line.section_filename({ trunc_width = 150 })
      local location      = line.section_location({ trunc_width = 75 })

      return line.combine_groups({
        { hl = mode_hl, strings = { string.upper(mode) } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
  set_vim_settings = false
})
require('mini.surround').setup()
