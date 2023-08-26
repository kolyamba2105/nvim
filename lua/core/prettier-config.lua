local group = require("core.autocmds")

local filetypes = {
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
    callback = function()
        local value = tonumber(vim.fn.system("prettier-output-config printWidth"))

        if value ~= nil then vim.cmd("setlocal colorcolumn=" .. value) end
    end,
    desc = "Set colorcolumn based on Prettier printWidth",
    group = group("PrettierOutputConfigPrintWidth"),
    pattern = filetypes,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local value = tonumber(vim.fn.system("prettier-output-config tabWidth"))

        if value ~= nil then
            vim.cmd("setlocal shiftwidth=" .. value)
            vim.cmd("setlocal softtabstop=" .. value)
            vim.cmd("setlocal tabstop=" .. value)
        end
    end,
    desc = "Set tab width based on Prettier tabWidth",
    group = group("PettierOutputConfigTabWidth"),
    pattern = filetypes,
})
