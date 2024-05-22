local picker = require("plugins.telescope.picker")

local M = {}

M.diagnostic_config = function()
    vim.diagnostic.config({
        float = {
            border = vim.g.neovide and "single" or "double",
            show_header = false,
        },
        severity_sort = true,
        virtual_text = false,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = vim.g.neovide and "single" or "double",
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = vim.g.neovide and "single" or "double",
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

-- TODO refactor on attach (higher-order function)
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
        rhs = picker("lsp_definitions"),
        desc = "Definitions",
    })
    M.map({
        lhs = "<leader>le",
        rhs = vim.diagnostic.open_float,
        desc = "Open diagnostic float",
    })
    M.map({
        lhs = "<leader>lh",
        rhs = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        desc = "Toggle inlay hints",
    })
    M.map({
        lhs = "<leader>ll",
        rhs = picker("diagnostics"),
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
        rhs = picker("lsp_references"),
        desc = "References",
    })
    M.map({
        lhs = "<leader>ls",
        rhs = picker("lsp_document_symbols"),
        desc = "Document symbols",
    })
    M.map({
        lhs = "<leader>lt",
        rhs = picker("lsp_type_definitions"),
        desc = "Type definitions",
    })
    M.map({
        lhs = "<leader>lw",
        rhs = picker("lsp_dynamic_workspace_symbols"),
        desc = "Dynamic workspace symbols",
    })
end

M.format = {
    autocmd = function(ft)
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function() vim.lsp.buf.format() end,
            desc = "Format",
            group = vim.api.nvim_create_augroup(ft .. "Format", { clear = true }),
        })
    end,
    command = function(bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format({ async = true }) end, {
            desc = "Format",
        })
    end,
    keymap = function() M.map({ lhs = "<leader>lf", rhs = vim.lsp.buf.format, desc = "Format" }) end,
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.default_config = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

M.executable_path = function(entries)
    table.sort(entries, function(a, b) return a.priority > b.priority end)

    for _, entry in ipairs(entries) do
        if vim.fn.filereadable(entry.path) ~= 0 then return entry.path end
    end

    return nil
end

return M
