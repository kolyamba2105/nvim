local common = require("user.lsp.common")

require("typescript").setup({
  disable_formatting = true,
  server = {
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
      common.on_attach(client, bufnr)
      common.buf_set_keymap("<leader>lo", "<cmd>TypescriptOrganizeImports<cr>")
      common.buf_set_keymap("<leader>lu", "<cmd>TypescriptRemoveUnused<cr>")
    end,
  },
})
