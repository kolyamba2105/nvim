local common = require("plugins.lsp.common")

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    common.buf_set_keymap("<leader>lf", vim.lsp.buf.format)
  end,
}
