local group = require("core.autocmds")

local function set_color_column(value) vim.cmd("setlocal colorcolumn=" .. value) end

local prettier_fts = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "jsonc",
    "markdown",
    "scss",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
    callback = function() set_color_column(vim.fn.system("prettier-print-width")) end,
    desc = "Set colorcolumn based on Prettier printWidth",
    group = group("PettierPrintWidthColorColumn"),
    pattern = prettier_fts,
})
