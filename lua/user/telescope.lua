local telescope = require('telescope')
local map = require('mappings')

local M = {}

function M.get_picker(picker)
  return function(options) return require('telescope.builtin')[picker](options) end
end

function M.get_picker_insert(picker)
  return function() M.get_picker(picker)({ initial_mode = 'insert' }) end
end

local opts = { silent = true }

map('n', '<leader>fa', M.get_picker('resume'), opts)
map('n', '<leader>fb', M.get_picker('buffers'), opts)
map('n', '<leader>fc', M.get_picker('command_history'), opts)
map('n', '<leader>ff', M.get_picker_insert('find_files'), opts)
map('n', '<leader>fg', M.get_picker_insert('live_grep'), opts)
map('n', '<leader>fh', M.get_picker_insert('help_tags'), opts)
map('n', '<leader>fj', M.get_picker('jumplist'), opts)
map('n', '<leader>fm', M.get_picker('marks'), opts)
map('n', '<leader>fr', M.get_picker('grep_string'), opts)
map('n', '<leader>fs', M.get_picker_insert('search_history'), opts)
map('n', '<leader>fq', M.get_picker('quickfix'), opts)

-- Git
map('n', '<leader>gc', M.get_picker('git_commits'), opts)
map('n', '<leader>gs', M.get_picker('git_status'), opts)
map('n', '<leader>gr', M.get_picker('git_branches'), opts)

-- File browser
local function file_browser_cwd()
  return telescope.extensions.file_browser.file_browser({
    cwd = vim.fn.expand('%:p:h'),
  })
end

map('n', '<C-n>', telescope.extensions.file_browser.file_browser, opts)
map('n', '<C-e>', file_browser_cwd, opts)

telescope.setup {
  defaults = require('telescope.themes').get_ivy({
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<c-h>'] = require('telescope.actions').file_split,
        ['<c-x>'] = false,
      },
      n = {
        ['<c-h>'] = require('telescope.actions').file_split,
        ['<c-x>'] = false,
      },
    },
  }),
  extensions = {
    file_browser = {
      grouped = true,
      hidden = true,
      initial_mode = 'normal',
    },
    ['ui-select'] = {
      initial_mode = 'normal',
    },
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

telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

return M;
