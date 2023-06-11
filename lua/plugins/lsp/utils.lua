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

M.map = function(opts)
    vim.keymap.set("n", opts.lhs, opts.rhs, {
        buffer = true,
        desc = opts.desc,
        noremap = true,
        silent = true,
    })
end

M.on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")

    M.map({
        lhs = "]g",
        rhs = vim.diagnostic.goto_next,
        desc = "Go to next diagnostic",
    })
    M.map({
        lhs = "[g",
        rhs = vim.diagnostic.goto_prev,
        desc = "Go to previous diagnostic",
    })
    M.map({
        lhs = "<leader>k",
        rhs = vim.lsp.buf.hover,
        desc = "Hover",
    })
    M.map({
        lhs = "<leader>la",
        rhs = vim.lsp.buf.code_action,
        desc = "Code action",
    })
    M.map({
        lhs = "<leader>ld",
        rhs = utils.get_picker("lsp_definitions"),
        desc = "Definitions",
    })
    M.map({
        lhs = "<leader>le",
        rhs = vim.diagnostic.open_float,
        desc = "Open diagnostic float",
    })
    M.map({
        lhs = "<leader>ll",
        rhs = utils.get_picker("diagnostics"),
        desc = "Diagnostics",
    })
    M.map({
        lhs = "<leader>ln",
        rhs = vim.lsp.buf.rename,
        desc = "Rename",
    })
    M.map({
        lhs = "<leader>lq",
        rhs = vim.diagnostic.setloclist,
        desc = "Set location list",
    })
    M.map({
        lhs = "<leader>lr",
        rhs = utils.get_picker("lsp_references"),
        desc = "References",
    })
    M.map({
        lhs = "<leader>ls",
        rhs = utils.get_picker_insert("lsp_document_symbols"),
        desc = "Document symbols",
    })
    M.map({
        lhs = "<leader>lt",
        rhs = utils.get_picker("lsp_type_definitions"),
        desc = "Type definitions",
    })
    M.map({
        lhs = "<leader>lw",
        rhs = utils.get_picker_insert("lsp_dynamic_workspace_symbols"),
        desc = "Dynamic workspace symbols",
    })
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
    keymap = function() M.map({ lhs = "<leader>lf", rhs = vim.lsp.buf.format, desc = "Format" }) end,
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

return M
