require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.cursorword').setup({ delay = 500 })
require('mini.misc').setup()
require('mini.pairs').setup()

vim.api.nvim_set_hl(0, "MiniCursorword", { bg = "#45475a", fg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "#45475a", fg = "#a6e3a1" })
