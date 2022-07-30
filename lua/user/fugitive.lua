local map = require('mappings').map

local opts = { noremap = true, silent = true }

map('n', '<leader>gg', '<cmd>Git<cr>', opts)
map('n', '<leader>gb', '<cmd>Git blame<cr>', opts)
map('n', '<leader>gp', '<cmd>Git push<cr>', opts)

map('n', '<leader>gf', '<cmd>diffget //2<cr>', opts)
map('n', '<leader>gj', '<cmd>diffget //3<cr>', opts)
