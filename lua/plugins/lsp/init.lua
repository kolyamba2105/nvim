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

            ts_ls = function()
                local function action(name) vim.lsp.buf.code_action({ apply = true, context = { only = { name } } }) end

                return {
                    capabilities = common.capabilities,
                    on_attach = function()
                        common.on_attach()
                        common.map({
                            lhs = "<leader>lm",
                            rhs = function() action("source.addMissingImports.ts") end,
                            desc = "TS - Add missing imports",
                        })
                        common.map({
                            lhs = "<leader>lo",
                            rhs = function() action("source.organizeImports.ts") end,
                            desc = "TS - Organize imports",
                        })
                        common.map({
                            lhs = "<leader>lu",
                            rhs = function() action("source.removeUnusedImports.ts") end,
                            desc = "TS - Remove unused imports",
                        })
                    end,
                    init_options = {
                        hostInfo = "neovim",
                        preferences = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = true,
                        },
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
