local common = require("plugins.lsp.common")

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    common.buf_set_keymap("<leader>lf", vim.lsp.buf.format)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format({ async = true }) end, {})
  end,
}
