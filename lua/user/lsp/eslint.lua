local common = require('user.lsp.common')

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function() vim.cmd [[ EslintFixAll ]] end,
      group = vim.api.nvim_create_augroup('LintFix', { clear = true }),
    })
  end,
}
