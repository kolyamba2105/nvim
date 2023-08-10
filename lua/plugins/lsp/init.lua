return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        local common = require("plugins.lsp.utils")

        common.diagnostic_config()

        local servers = {
            bashls = nil,
            cssls = nil,
            cssmodules_ls = nil,
            efm = function()
                local prettier_executable = common.executable_path({
                    { priority = 0, path = "prittier" },
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

                        local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
                        if not vim.tbl_contains(fts, vim.bo.filetype) then common.format.keymap() end
                    end,
                    root_dir = lsp.util.root_pattern(".git"),
                    settings = {
                        languages = languages,
                        rootMarkers = { ".git", "package.json" },
                    },
                }
            end,
            emmet_ls = nil,
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
            html = nil,
            jsonls = nil,
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
            tailwindcss = nil,
            yamlls = nil,
        }

        for server, config in pairs(servers) do
            if config == nil then
                lsp[server].setup(common.default_config)
            else
                lsp[server].setup(config())
            end
        end
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    event = "BufReadPost",
}
