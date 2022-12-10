vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
  desc = 'Hightlight selection on yank',
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = false }),
  pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.cmd('compiler tsc | setlocal makeprg=yarn\\ tsc')
  end,
  group = vim.api.nvim_create_augroup('TypeScriptOptions', { clear = false }),
  pattern = {
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
})
