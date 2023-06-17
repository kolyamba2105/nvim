local group = require("core.autocmds")

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local value = tonumber(vim.fn.system("prettier-print-width"))

        if value ~= nil then vim.cmd("setlocal colorcolumn=" .. value) end
    end,
    desc = "Set colorcolumn based on Prettier printWidth",
    group = group("PettierPrintWidthColorColumn"),
    pattern = {
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
    },
})
