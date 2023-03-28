local function group(name) return vim.api.nvim_create_augroup(name, { clear = false }) end

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
    desc = "Hightlight selection on yank",
    group = group("HighlightYank"),
    pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.cmd("compiler tsc | setlocal makeprg=yarn\\ tsc") end,
    desc = "Set compiler options for TypeScript files",
    group = group("TypeScriptOptions"),
    pattern = {
        "typescript",
        "typescript.tsx",
        "typescriptreact",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
        vim.opt.tabstop = 4
    end,
    desc = "Set tabstop for Lua files",
    group = group("LuaTabStop"),
    pattern = {
        "lua",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function() vim.o.showtabline = 0 end,
    desc = "Disable tabline on init",
    group = group("DisableTabline"),
    pattern = "*",
})

return group
