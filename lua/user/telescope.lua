local telescope = require('telescope')
local map = require('mappings')

local opts = { silent = true }

local function get_picker(picker)
  return function()
    return require('telescope.builtin')[picker](require('telescope.themes').get_ivy({}))
  end

end

map('n', '<leader>ta', require('telescope.builtin').resume, opts)
map('n', '<leader>tb', get_picker('buffers'), opts)
map('n', '<leader>tc', get_picker('command_history'), opts)
map('n', '<leader>tf', get_picker('find_files'), opts)
map('n', '<leader>tg', get_picker('live_grep'), opts)
map('n', '<leader>th', get_picker('help_tags'), opts)
map('n', '<leader>tj', get_picker('jumplist'), opts)
map('n', '<leader>tm', get_picker('marks'), opts)
map('n', '<leader>tr', get_picker('grep_string'), opts)
map('n', '<leader>ts', get_picker('search_history'), opts)

-- Git
map('n', '<leader>gc', get_picker('git_commits'), opts)
map('n', '<leader>gs', get_picker('git_status'), opts)
map('n', '<leader>gr', get_picker('git_branches'), opts)

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
    },
  },
  pickers = {
    theme = 'ivy',
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

return get_picker
