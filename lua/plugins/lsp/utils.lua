local map = require("core.mappings")
local utils = require("plugins.telescope.utils")

local M = {}

M.diagnostic_config = function()
    vim.diagnostic.config({
        float = {
            border = "rounded",
            show_header = false,
        },
        severity_sort = true,
        virtual_text = false,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
end

M.map = function(lhs, rhs) map("n", lhs, rhs, { buffer = true, noremap = true, silent = true }) end

M.on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")

    M.map("]g", vim.diagnostic.goto_next)
    M.map("[g", vim.diagnostic.goto_prev)
    M.map("<leader>k", vim.lsp.buf.hover)
    M.map("<leader>la", vim.lsp.buf.code_action)
    M.map("<leader>ld", utils.get_picker("lsp_definitions"))
    M.map("<leader>le", vim.diagnostic.open_float)
    M.map("<leader>ll", utils.get_picker("diagnostics"))
    M.map("<leader>ln", vim.lsp.buf.rename)
    M.map("<leader>lq", vim.diagnostic.setloclist)
    M.map("<leader>lr", utils.get_picker("lsp_references"))
    M.map("<leader>ls", utils.get_picker_insert("lsp_document_symbols"))
    M.map("<leader>lt", utils.get_picker("lsp_type_definitions"))
    M.map("<leader>lw", utils.get_picker_insert("lsp_dynamic_workspace_symbols"))
end

M.format = {
    autocmd = function(ft)
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function() vim.lsp.buf.format() end,
            group = vim.api.nvim_create_augroup(ft .. "Format", { clear = true }),
        })
    end,
    command = function(bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format({ async = true }) end, {})
    end,
    keymap = function() M.map("<leader>lf", vim.lsp.buf.format) end,
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

return M
