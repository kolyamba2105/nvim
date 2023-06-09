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

                        if not vim.tbl_contains(fts, vim.bo.filetype) then common.format.keymap() end
                    end,
                    root_dir = require("lspconfig").util.root_pattern(".git"),
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
                        common.map("<leader>lf", function() vim.cmd("EslintFixAll") end)
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

        local typescript = require("typescript")

        typescript.setup({
            disable_formatting = true,
            server = {
                capabilities = common.capabilities,
                on_attach = function(client, bufnr)
                    common.on_attach(client, bufnr)
                    common.map("<leader>lm", typescript.actions.addMissingImports)
                    common.map("<leader>lo", typescript.actions.organizeImports)
                    common.map("<leader>lu", typescript.actions.removeUnused)
                end,
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
        "jose-elias-alvarez/typescript.nvim",
    },
    event = "BufRead",
}
