return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        local common = require("plugins.lsp.utils")

        common.diagnostic_config()

        local servers = {
            bashls = "default",
            cssls = "default",
            cssmodules_ls = "default",
            efm = function()
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
                        common.format.command(bufnr)

                        local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
                        common.format.keymap(vim.tbl_contains(fts, vim.bo.filetype) and "p" or "f")
                    end,
                    root_dir = lsp.util.root_pattern(".git"),
                    settings = {
                        languages = languages,
                        rootMarkers = { ".git", "package.json" },
                    },
                }
            end,
            emmet_ls = "default",
            eslint = function()
                return {
                    capabilities = common.capabilities,
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.map({ lhs = "<leader>lf", rhs = "<cmd>EslintFixAll<cr>", desc = "ESLint - Fix all" })
                    end,
                }
            end,
            graphql = function()
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
            end,
            html = "default",
            jsonls = "default",
            lua_ls = function()
                return {
                    capabilities = common.capabilities,
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.format.autocmd("Lua")
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
            end,
            ocamllsp = function()
                return {
                    capabilities = common.capabilities,
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.format.command(bufnr)
                        common.format.keymap()
                    end,
                }
            end,
            prismals = function()
                return {
                    capabilities = common.capabilities,
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.format.autocmd("Prisma")
                    end,
                }
            end,
            rust_analyzer = "default",
            tailwindcss = "default",
            yamlls = "default",
        }

        -- https://github.com/typescript-language-server/typescript-language-server
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
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

        for server, config in pairs(servers) do
            if config == "default" then
                lsp[server].setup(common.default_config)
            else
                lsp[server].setup(config())
            end
        end
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "nvim-lua/plenary.nvim",
        "pmizio/typescript-tools.nvim",
    },
    event = "BufRead",
}
