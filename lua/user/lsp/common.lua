local M = {}

M.diagnostic_config = function()
  vim.diagnostic.config {
    float = {
      border = 'rounded',
      show_header = false,
    },
    severity_sort = true,
    virtual_text = false,
  }

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded"
  })
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded"
  })
end

M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr or 0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local buf_set_keymap = function(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr or 0, 'n', lhs, rhs, { noremap = true, silent = true })
  end

  buf_set_keymap(']g', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  buf_set_keymap('[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  buf_set_keymap('<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>')
  buf_set_keymap('<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>')
  buf_set_keymap('<leader>ld', '<cmd>Telescope lsp_definitions<cr>')
  buf_set_keymap('<leader>le', '<cmd>lua vim.diagnostic.open_float()<cr>')
  buf_set_keymap('<leader>ll', '<cmd>Telescope diagnostics<cr>')
  buf_set_keymap('<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>')
  buf_set_keymap('<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>')
  buf_set_keymap('<leader>lr', '<cmd>Telescope lsp_references<cr>')
  buf_set_keymap('<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
  buf_set_keymap('<leader>lt', '<cmd>Telescope lsp_type_definitions<cr>')
  buf_set_keymap('<leader>lw', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')

  local format_group = vim.api.nvim_create_augroup('Format', { clear = true })

  if (client.name == "sumneko_lua") then
    buf_set_keymap('<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>')

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function() vim.lsp.buf.format() end,
      group = format_group,
    })

    return
  else
    buf_set_keymap('<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true, name = "efm" })<cr>')

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function() vim.lsp.buf.format({ name = "efm" }) end,
      group = format_group,
    })
  end
end

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

return M
