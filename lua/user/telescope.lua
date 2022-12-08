local telescope = require('telescope')
local map = require('mappings')

local opts = { silent = true }

local function get_picker(picker)
  return function(options)
    return require('telescope.builtin')[picker](require('telescope.themes').get_ivy(options))
  end
end

local enter_normal_mode = {
  on_complete = { function() vim.cmd('stopinsert') end }
}

local function get_picker_normal(picker)
  return function() get_picker(picker)(enter_normal_mode) end
end

map('n', '<leader>ta', require('telescope.builtin').resume, opts)
map('n', '<leader>tb', get_picker_normal('buffers'), opts)
map('n', '<leader>tc', get_picker('command_history'), opts)
map('n', '<leader>tf', get_picker('find_files'), opts)
map('n', '<leader>tg', get_picker('live_grep'), opts)
map('n', '<leader>th', get_picker('help_tags'), opts)
map('n', '<leader>tj', get_picker_normal('jumplist'), opts)
map('n', '<leader>tm', get_picker('marks'), opts)
map('n', '<leader>tr', get_picker_normal('grep_string'), opts)
map('n', '<leader>ts', get_picker('search_history'), opts)
map('n', '<leader>tq', get_picker_normal('quickfix'), opts)

-- Git
map('n', '<leader>gc', get_picker('git_commits'), opts)
map('n', '<leader>gs', get_picker_normal('git_status'), opts)
map('n', '<leader>gr', get_picker_normal('git_branches'), opts)

-- File browser
local function file_browser()
  return telescope.extensions.file_browser.file_browser(enter_normal_mode)
end

local function file_browser_cwd()
  return telescope.extensions.file_browser.file_browser({
    cwd = vim.fn.expand('%:p:h'),
    on_complete = { function() vim.cmd('stopinsert') end },
  })
end

map('n', '<C-n>', file_browser, opts)
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

return get_picker
