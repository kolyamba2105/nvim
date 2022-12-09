local telescope = require('telescope')
local map = require('mappings')

local M = {}

local opts = { silent = true }

M.get_picker = function(picker)
  return function(options)
    return require('telescope.builtin')[picker](require('telescope.themes').get_ivy(options))
  end
end

local enter_normal_mode = {
  initial_mode = 'normal',
}

M.get_picker_normal = function(picker)
  return function() M.get_picker(picker)(enter_normal_mode) end
end

map('n', '<leader>ta', require('telescope.builtin').resume, opts)
map('n', '<leader>tb', M.get_picker_normal('buffers'), opts)
map('n', '<leader>tc', M.get_picker('command_history'), opts)
map('n', '<leader>tf', M.get_picker('find_files'), opts)
map('n', '<leader>tg', M.get_picker('live_grep'), opts)
map('n', '<leader>th', M.get_picker('help_tags'), opts)
map('n', '<leader>tj', M.get_picker_normal('jumplist'), opts)
map('n', '<leader>tm', M.get_picker('marks'), opts)
map('n', '<leader>tr', M.get_picker_normal('grep_string'), opts)
map('n', '<leader>ts', M.get_picker('search_history'), opts)
map('n', '<leader>tq', M.get_picker_normal('quickfix'), opts)

-- Git
map('n', '<leader>gc', M.get_picker('git_commits'), opts)
map('n', '<leader>gs', M.get_picker_normal('git_status'), opts)
map('n', '<leader>gr', M.get_picker_normal('git_branches'), opts)

-- File browser
local function file_browser_cwd()
  return telescope.extensions.file_browser.file_browser({
    cwd = vim.fn.expand('%:p:h'),
  })
end

map('n', '<C-n>', telescope.extensions.file_browser.file_browser, opts)
map('n', '<C-e>', file_browser_cwd, opts)

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
    },
  },
  extensions = {
    file_browser = {
      grouped = true,
      hidden = true,
      initial_mode = 'normal',
      theme = 'ivy',
    }
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

telescope.load_extension('file_browser')
telescope.load_extension('ui-select')

return M;
