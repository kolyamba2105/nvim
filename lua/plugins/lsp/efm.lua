local common = require("plugins.lsp.common")

local prettier_config = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local lua_config = {
  formatCommand = "stylua --color Never -",
  formatStdin = true,
}

local rust_config = {
  formatCommand = "rustfmt",
  formatStdin = true,
}

-- Reference: https://github.com/creativenull/efmls-configs-nvim
local languages = {
  css = { prettier_config },
  html = { prettier_config },
  javascript = { prettier_config },
  javascriptreact = { prettier_config },
  json = { prettier_config },
  jsonc = { prettier_config },
  lua = { lua_config },
  markdown = { prettier_config },
  rust = { rust_config },
  sass = { prettier_config },
  scss = { prettier_config },
  typescript = { prettier_config },
  typescriptreact = { prettier_config },
  yaml = { prettier_config },
}

return {
  cmd = { "efm-langserver" },
  capabilities = common.capabilities,
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format({ async = true }) end, {})

    if not vim.tbl_contains({ "javascript", "javascriptreact", "typescript", "typescriptreact" }, vim.bo.filetype) then
      common.buf_set_keymap("<leader>lf", vim.lsp.buf.format)
    end
  end,
  root_dir = require("lspconfig").util.root_pattern(".git"),
  settings = {
    languages = languages,
    rootMarkers = { ".git", "package.json" },
  },
}
