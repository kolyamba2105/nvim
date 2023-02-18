local common = require("user.plugins.lsp.common")

return {
  capabilities = common.capabilities,
  filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
}
