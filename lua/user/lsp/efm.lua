local common = require('user.lsp.common')
local keys = require('common').keys

local prettier_config = {
  formatCommand = [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier") --stdin-filepath ${INPUT}]],
  formatStdin = true,
}

local rust_config = {
  formatCommand = "rustfmt",
  formatStdin = true,
}

local languages = {
  css = { prettier_config },
  html = { prettier_config },
  javascript = { prettier_config },
  javascriptreact = { prettier_config },
  json = { prettier_config },
  markdown = { prettier_config },
  sass = { prettier_config },
  scss = { prettier_config },
  rust = { rust_config },
  typescript = { prettier_config },
  typescriptreact = { prettier_config },
  yaml = { prettier_config }
}

return {
  cmd = { 'efm-langserver' },
  capabilities = common.capabilities,
  filetypes = keys(languages),
  init_options = { documentFormatting = true },
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    common.buf_set_keymap('<leader>lf', function() vim.lsp.buf.format({ async = true }) end)

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function() vim.lsp.buf.format({ name = "efm" }) end,
      group = vim.api.nvim_create_augroup('EfmFormat', { clear = true }),
    })
  end,
  root_dir = require('lspconfig').util.root_pattern('.git'),
  settings = {
    languages = languages,
    rootMarkers = { '.git', 'package.json' },
  },
}
