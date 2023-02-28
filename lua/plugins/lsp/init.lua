local lsp = require("lspconfig")
local common = require("plugins.lsp.common")

common.diagnostic_config()

lsp.bashls.setup(common.default_config)
lsp.cssls.setup(common.default_config)
lsp.cssmodules_ls.setup(common.default_config)
lsp.efm.setup(require("plugins.lsp.efm"))
lsp.emmet_ls.setup(require("plugins.lsp.emmet"))
lsp.eslint.setup(require("plugins.lsp.eslint"))
lsp.graphql.setup(require("plugins.lsp.graphql"))
lsp.html.setup(common.default_config)
lsp.jsonls.setup(common.default_config)
lsp.lua_ls.setup(require("plugins.lsp.sumneko"))
lsp.ocamllsp.setup(require("plugins.lsp.ocaml"))
lsp.prismals.setup(require("plugins.lsp.prisma"))
lsp.rust_analyzer.setup(common.default_config)
lsp.tailwindcss.setup(common.default_config)
lsp.yamlls.setup(common.default_config)

require("plugins.lsp.typescript")
