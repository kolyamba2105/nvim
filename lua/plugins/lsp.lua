local picker = require("plugins.telescope.picker")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(_, buffer)
    vim.keymap.set("n", "]g", vim.diagnostic.goto_next, {
        buffer = buffer,
        desc = "Go to next diagnostic",
        silent = true,
    })
    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, {
        buffer = buffer,
        desc = "Go to prev diagnostic",
        silent = true,
    })
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {
        buffer = buffer,
        desc = "Hover",
        silent = true,
    })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
        buffer = buffer,
        desc = "Code action",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ld", picker("lsp_definitions"), {
        buffer = buffer,
        desc = "Definitions",
        silent = true,
    })
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, {
        buffer = buffer,
        desc = "Open diagnostic float",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {
        buffer = buffer,
        desc = "Toggle inlay hints",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ll", picker("diagnostics"), {
        buffer = buffer,
        desc = "Diagnostics",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {
        buffer = buffer,
        desc = "Rename",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, {
        buffer = buffer,
        desc = "Set location list",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lr", picker("lsp_references"), {
        buffer = buffer,
        desc = "References",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ls", picker("lsp_document_symbols"), {
        buffer = buffer,
        desc = "Document symbols",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lt", picker("lsp_type_definitions"), {
        buffer = buffer,
        desc = "Type definitions",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lw", picker("lsp_dynamic_workspace_symbols"), {
        buffer = buffer,
        desc = "Dynamic workspace symbols",
        silent = true,
    })
end

--- @class ExecEntry
--- @field priority number
--- @field path string

--- @param entries ExecEntry[]
--- @return string | nil
local function executable_path(entries)
    table.sort(entries, function(a, b) return a.priority > b.priority end)

    for _, entry in ipairs(entries) do
        if vim.fn.filereadable(entry.path) ~= 0 then return entry.path end
    end

    return nil
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.diagnostic.config({
            float = {
                border = vim.g.neovide and "single" or "double",
                show_header = false,
            },
            severity_sort = true,
            underline = true,
            virtual_text = false,
        })

        vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach })

        local prettier_executable = executable_path({
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
            css = {
                prettier_config,
            },
            html = {
                prettier_config,
            },
            javascript = {
                prettier_config,
            },
            javascriptreact = {
                prettier_config,
            },
            json = {
                prettier_config,
            },
            jsonc = {
                prettier_config,
            },
            lua = {
                lua_config,
            },
            markdown = {
                prettier_config,
            },
            sass = {
                prettier_config,
            },
            scss = {
                prettier_config,
            },
            typescript = {
                prettier_config,
            },
            typescriptreact = {
                prettier_config,
            },
            yaml = {
                prettier_config,
            },
        }

        vim.lsp.config("efm", {
            capabilities = capabilities,
            filetypes = vim.tbl_keys(languages),
            init_options = { documentFormatting = true },
            on_attach = function(_, buffer)
                vim.api.nvim_buf_create_user_command(buffer, "LspFormat", function() vim.lsp.buf.format() end, {
                    desc = "EFM - Format",
                })

                vim.api.nvim_create_autocmd("BufWritePre", {
                    callback = function() vim.lsp.buf.format() end,
                    desc = "Format",
                    group = vim.api.nvim_create_augroup("format/efm", { clear = true }),
                })
            end,
            settings = {
                languages = languages,
                rootMarkers = { ".git", "package.json" },
            },
        })

        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
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
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })

        vim.lsp.config("vtsls", {
            capabilities = capabilities,
            on_attach = function(client, buffer)
                on_attach(client, buffer)

                local function action(name)
                    vim.lsp.buf.code_action({ apply = true, context = { diagnostics = {}, only = { name } } })
                end

                -- stylua: ignore start
                vim.api.nvim_buf_create_user_command(buffer, "LspAddMissingImports", function() action("source.addMissingImports.ts") end, {
                    desc = "TypeScript - Add missing imports",
                })
                vim.api.nvim_buf_create_user_command(buffer, "LspOrganizeImports", function() action("source.organizeImports") end, {
                    desc = "TypeScript - Organize imports",
                })
                -- stylua: ignore end
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
                javascript = {
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
                },
                typescript = {
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
                },
            },
        })

        vim.lsp.enable({
            "bashls",
            "cssls",
            "cssmodules_ls",
            "efm",
            "emmet_language_server",
            "eslint",
            "html",
            "jsonls",
            "lua_ls",
            "tailwindcss",
            "vtsls",
            "yamlls",
        })
    end,
    event = "BufReadPost",
}
