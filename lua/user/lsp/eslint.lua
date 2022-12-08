local common = require('user.lsp.common')

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    common.buf_set_keymap('<C-f>', function() vim.cmd('EslintFixAll') end)
  end,
}
