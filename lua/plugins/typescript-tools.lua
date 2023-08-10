-- https://github.com/typescript-language-server/typescript-language-server
local lsp = require("lspconfig")
local common = require("plugins.lsp.utils")

local bin = "node_modules/typescript/lib/tsserver.js"
local tsserver_path = common.executable_path({
    { priority = 0, path = string.format("%s/%s/%s", os.getenv("HOME"), ".config/yarn/global", bin) },
    { priority = 1, path = string.format("%s/%s", vim.loop.cwd(), bin) },
})

return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
    event = "BufReadPost",
    config = function()
        require("typescript-tools").setup({
            capabilities = common.capabilities,
            handlers = {
                ["textDocument/publishDiagnostics"] = require("typescript-tools.api").filter_diagnostics({
                    80001,
                    80005,
                    80006,
                }),
            },
            on_attach = function()
                common.on_attach()
                common.map({
                    lhs = "<leader>lm",
                    rhs = "<cmd>TSToolsAddMissingImports<cr>",
                    desc = "TypeScript - Add missing imports",
                })
                common.map({
                    lhs = "<leader>lo",
                    rhs = "<cmd>TSToolsOrganizeImports<cr>",
                    desc = "TypeScript - Organize imports",
                })
                common.map({
                    lhs = "<leader>lu",
                    rhs = "<cmd>TSToolsRemoveUnusedImports<cr>",
                    desc = "TypeScript - Remove unused imports",
                })
            end,
            root_dir = lsp.util.root_pattern(".git"),
            settings = {
                tsserver_path = tsserver_path,
                tsserver_file_preferences = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                },
            },
        })
    end,
}
