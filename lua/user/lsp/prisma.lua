local common = require('user.lsp.common')

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    common.buf_set_keymap('<leader>lf', function() vim.lsp.buf.format({ async = true }) end)

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function() vim.lsp.buf.format() end,
      group = vim.api.nvim_create_augroup('PrismaFormat', { clear = true }),
    })
  end,
}
