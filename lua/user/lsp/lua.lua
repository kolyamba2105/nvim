local common = require('user.lsp.common')

return {
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
