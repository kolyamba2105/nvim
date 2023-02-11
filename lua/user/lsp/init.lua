local lsp = require("lspconfig")
local common = require("user.lsp.common")

common.diagnostic_config()

lsp.bashls.setup(common.default_config)
lsp.cssls.setup(common.default_config)
lsp.cssmodules_ls.setup(common.default_config)
lsp.efm.setup(require("user.lsp.efm"))
lsp.emmet_ls.setup(require("user.lsp.emmet"))
lsp.eslint.setup(require("user.lsp.eslint"))
lsp.graphql.setup(require("user.lsp.graphql"))
lsp.html.setup(common.default_config)
lsp.jsonls.setup(common.default_config)
lsp.prismals.setup(require("user.lsp.prisma"))
lsp.rust_analyzer.setup(common.default_config)
lsp.sumneko_lua.setup(require("user.lsp.sumneko"))
lsp.tailwindcss.setup(common.default_config)
lsp.yamlls.setup(common.default_config)

require("user.lsp.typescript")
