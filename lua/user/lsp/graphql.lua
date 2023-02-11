local common = require("user.lsp.common")

return {
  capabilities = common.capabilities,
  filetypes = {
    "graphql",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  on_attach = common.on_attach,
}
