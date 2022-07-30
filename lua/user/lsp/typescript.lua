local buf_map = require('mappings').buf_map
local common = require('user.lsp.common')

require('typescript').setup({
  disable_formatting = true,
  server = {
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
      common.on_attach(client, bufnr)

      buf_map(bufnr, 'n', '<leader>lo', '<cmd>TypescriptOrganizeImports<cr>', { noremap = true, silent = true })
      buf_map(bufnr, 'n', '<leader>lu', '<cmd>TypescriptRemoveUnused<cr>', { noremap = true, silent = true })
    end,
  }
})
