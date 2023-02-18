local common = require("user.plugins.lsp.common")

return {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function() vim.lsp.buf.format() end,
      group = vim.api.nvim_create_augroup("LuaFormat", { clear = true }),
    })
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
