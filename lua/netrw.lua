local map = require('mappings').map

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '.DS_Store'

map('n', '<leader>e', '<cmd>Ex<cr>', { noremap = true })
