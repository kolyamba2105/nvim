local map = require('mappings')

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '.DS_Store'

map('n', '<C-n>', '<cmd>Lexplore<cr>')
map('n', '<leader>e', '<cmd>Ex<cr>')
