return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        local common = require("plugins.lsp.utils")

        common.diagnostic_config()

        local servers = {
            efm = function()
                local prettier_executable = common.executable_path({
                    { priority = 0, path = string.format("%s/%s", "/opt/homebrew/bin", "prettier") },
                    { priority = 1, path = string.format("%s/%s", vim.loop.cwd(), "node_modules/.bin/prettier") },
                })
                local prettier_config = {
                    formatCommand = string.format("%s --stdin-filepath ${INPUT}", prettier_executable),
                    formatStdin = true,
                }

                local lua_config = {
                    formatCommand = "stylua --color Never -",
                    formatStdin = true,
                }

                local languages = {
                    css = { prettier_config },
                    html = { prettier_config },
                    javascript = { prettier_config },
                    javascriptreact = { prettier_config },
                    json = { prettier_config },
                    jsonc = { prettier_config },
                    lua = { lua_config },
                    markdown = { prettier_config },
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
                        common.format.keymap()
                    end,
                    root_dir = lsp.util.root_pattern(".git"),
                    settings = {
                        languages = languages,
                        rootMarkers = { ".git", "package.json" },
                    },
                }
            end,

            eslint = function()
                return {
                    capabilities = common.capabilities,
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.map({ lhs = "<leader>lx", rhs = "<cmd>EslintFixAll<cr>", desc = "ESLint - Fix all" })
                    end,
                }
            end,

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

            vtsls = function()
                local settings = {
                    inlayHints = {
                        enumMemberValues = {
                            enabled = true,
                        },
                        functionLikeReturnTypes = {
                            enabled = true,
                        },
                        parameterNames = {
                            enabled = "literals",
                        },
                        parameterTypes = {
                            enabled = true,
                        },
                        propertyDeclarationTypes = {
                            enabled = true,
                        },
                        variableTypes = {
                            enabled = true,
                        },
                    },
                }

                local function action(name)
                    return function()
                        vim.lsp.buf.code_action({ apply = true, context = { diagnostics = {}, only = { name } } })
                    end
                end

                return {
                    capabilities = common.capabilities,
                    on_attach = function()
                        common.on_attach()

                        common.map({
                            lhs = "<leader>lm",
                            rhs = action("source.addMissingImports.ts"),
                            desc = "TypeScript - Add missing imports",
                        })
                        common.map({
                            lhs = "<leader>lo",
                            rhs = action("source.organizeImports"),
                            desc = "TypeScript - Organize imports",
                        })
                    end,
                    settings = {
                        vtsls = {
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                    entriesLimit = 1000,
                                },
                            },
                        },
                        javascript = settings,
                        typescript = settings,
                    },
                }
            end,

            bashls = "default",
            cssls = "default",
            cssmodules_ls = "default",
            emmet_language_server = "default",
            html = "default",
            jsonls = "default",
            tailwindcss = "default",
            yamlls = "default",
        }

        for server, config in pairs(servers) do
            if config == "default" then
                lsp[server].setup(common.default_config)
            else
                lsp[server].setup(config())
            end
        end
    end,
    event = "BufReadPost",
}
