return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        local common = require("plugins.lsp.utils")
        local try_catch = require("utils.try-catch")

        common.diagnostic_config()

        local servers = {
            bashls = "default",
            cssls = "default",
            cssmodules_ls = "default",
            efm = function()
                local prettier_executable = common.executable_path({
                    { priority = 0, path = string.format("%s/%s", os.getenv("HOME"), ".yarn/bin/prettier") },
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

                local function resolve_package_json_path(bufnr)
                    local project_path = lsp.util.find_package_json_ancestor(vim.api.nvim_buf_get_name(bufnr))

                    if not project_path then error("Unable to resolve package.json path!") end

                    return string.format("%s/%s", project_path, "package.json")
                end

                return {
                    cmd = { "efm-langserver" },
                    capabilities = common.capabilities,
                    filetypes = vim.tbl_keys(languages),
                    init_options = { documentFormatting = true },
                    on_attach = function(client, bufnr)
                        common.on_attach(client, bufnr)
                        common.format.command(bufnr)

                        local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

                        if not vim.tbl_contains(fts, vim.bo.filetype) then return common.format.keymap() end

                        local path = try_catch(resolve_package_json_path, bufnr)

                        if not path.success then return print(path.error) end

                        local json = try_catch(require("utils.json").decode_json_file, path.data)

                        if not json.success then return print(json.error) end

                        if not json.data["devDependencies"]["eslint-plugin-prettier"] then
                            return common.format.keymap()
                        end
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
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    event = "BufReadPost",
}
