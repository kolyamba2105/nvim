local telescope = require('user.telescope')

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

M.buf_set_keymap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { buffer = true, noremap = true, silent = true })
end

M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr or 0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  M.buf_set_keymap(']g', vim.diagnostic.goto_next)
  M.buf_set_keymap('[g', vim.diagnostic.goto_prev)
  M.buf_set_keymap('<leader>k', vim.lsp.buf.hover)
  M.buf_set_keymap('<leader>la', vim.lsp.buf.code_action)
  M.buf_set_keymap('<leader>ld', telescope.get_picker('lsp_definitions'))
  M.buf_set_keymap('<leader>le', vim.diagnostic.open_float)
  M.buf_set_keymap('<leader>ll', telescope.get_picker('diagnostics'))
  M.buf_set_keymap('<leader>ln', vim.lsp.buf.rename)
  M.buf_set_keymap('<leader>lq', vim.diagnostic.setloclist)
  M.buf_set_keymap('<leader>lr', telescope.get_picker('lsp_references'))
  M.buf_set_keymap('<leader>ls', telescope.get_picker_insert('lsp_document_symbols'))
  M.buf_set_keymap('<leader>lt', telescope.get_picker('lsp_type_definitions'))
  M.buf_set_keymap('<leader>lw', telescope.get_picker_insert('lsp_dynamic_workspace_symbols'))
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

return M
