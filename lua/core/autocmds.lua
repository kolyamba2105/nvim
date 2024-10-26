local function group(name) return vim.api.nvim_create_augroup(name, { clear = false }) end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.colorcolumn = "120"
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
        vim.opt.tabstop = 4
    end,
    desc = "Set Vim settings for Lua files",
    group = group("LuaEditorSettings"),
    pattern = {
        "lua",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.opt.textwidth = 80 end,
    desc = "Set editor options for *.md files",
    group = group("MarkDownOptions"),
    pattern = {
        "markdown",
    },
})

return group
