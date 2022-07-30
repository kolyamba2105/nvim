local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap

-- Move between windows (splits)
map('n', '<C-A-h>', '<cmd>wincmd h<cr>', { noremap = true, silent = true })
map('n', '<C-A-j>', '<cmd>wincmd j<cr>', { noremap = true, silent = true })
map('n', '<C-A-k>', '<cmd>wincmd k<cr>', { noremap = true, silent = true })
map('n', '<C-A-l>', '<cmd>wincmd l<cr>', { noremap = true, silent = true })

-- create splits
map('n', '<leader>h', '<cmd>sp<cr>', { noremap = true, silent = true })
map('n', '<leader>v', '<cmd>vsp<cr>', { noremap = true, silent = true })

-- Close current buffer/window
map('n', '<C-c>', '<cmd>close<cr>', { noremap = true, silent = true })
map('n', '<C-d>', '<cmd>bdelete<cr>', { noremap = true, silent = true })

-- Save file
map('n', '<leader>w', '<cmd>w<cr>', { noremap = true })
map('n', '<leader>W', '<cmd>wall<cr>', { noremap = true })

-- Sort visually selected items
map('v', '<leader>s', '<cmd>sort<cr>', { noremap = true })

-- Apply macros
map('n', 'Q', '@q', { noremap = true })
map('v', 'Q', '<cmd>norm @q<cr>', { noremap = true })

return { buf_map = buf_map, map = map }
