local common = require("plugins.lsp.common")

return {
    capabilities = common.capabilities,
    filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
}
