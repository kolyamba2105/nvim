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

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
end

M.on_attach = function(_, bufnr)
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr or 0, ...) end
  local buf_set_option = function(...) vim.api.nvim_buf_set_option(bufnr or 0, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>Telescope diagnostics<CR>', opts)
  buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  buf_set_keymap('n', '<leader>lt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>lw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)

  buf_set_keymap('n', '<leader>lf', [[
    <cmd>lua vim.lsp.buf.format({ async = true, filter = function(client) return client.name == "efm" or client.name == "sumneko_lua" end })<CR>
  ]], opts)

  vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      vim.lsp.buf.format({
        filter = function(client) return client.name == "efm" or client.name == "sumneko_lua" end
      })
    end,
    group = vim.api.nvim_create_augroup('Format', { clear = true }),
  })
end

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

return M
