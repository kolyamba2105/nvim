local telescope = require('telescope')
local map = require('mappings')

local opts = { silent = true }

map('n', '<leader>tb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>tc', '<cmd>Telescope command_history<cr>', opts)
map('n', '<leader>tf', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>tg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>th', '<cmd>Telescope help_tags<cr>', opts)
map('n', '<leader>tj', '<cmd>Telescope jumplist<cr>', opts)
map('n', '<leader>tm', '<cmd>Telescope marks<cr>', opts)
map('n', '<leader>tr', '<cmd>Telescope grep_string<cr>', opts)
map('n', '<leader>ts', '<cmd>Telescope search_history<cr>', opts)
map('n', '<leader>tt', '<cmd>Telescope file_browser<cr>', opts)

-- Git
map('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', opts)
map('n', '<leader>gs', '<cmd>Telescope git_status<cr>', opts)
map('n', '<leader>gr', '<cmd>Telescope git_branches<cr>', opts)

telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = "delete_buffer",
        },
      },
    },
    find_files = {
      hidden = true,
    },
    file_browser = {
      hidden = true,
    },
  },
}

telescope.load_extension('ui-select')
