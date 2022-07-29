-- Move between windows (splits)
vim.api.nvim_set_keymap('n', '<C-A-h>', '<CMD>wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-j>', '<CMD>wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-k>', '<CMD>wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-l>', '<CMD>wincmd l<CR>', { noremap = true, silent = true })

-- Create splits
vim.api.nvim_set_keymap('n', '<leader>h', '<CMD>sp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>v', '<CMD>vsp<CR>', { noremap = true, silent = true })

-- Close current buffer/window
vim.api.nvim_set_keymap('n', '<C-c>', '<CMD>close<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<CMD>bdelete<CR>', { noremap = true, silent = true })

-- Save file
vim.api.nvim_set_keymap('n', '<leader>w', '<CMD>w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>W', '<CMD>wall<CR>', { noremap = true })

-- Sort visually selected items
vim.api.nvim_set_keymap('v', '<leader>s', '<CMD>sort<CR>', { noremap = true })

-- Apply macros
vim.api.nvim_set_keymap('n', 'Q', '@q', { noremap = true })
vim.api.nvim_set_keymap('v', 'Q', '<CMD>norm @q<CR>', { noremap = true })
