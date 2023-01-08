local map = require('mappings')

require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
  },
}

map('n', '<C-b>', '<cmd>BufferLinePick<cr>')
