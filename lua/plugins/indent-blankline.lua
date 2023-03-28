local group = require("core.autocmds")
local colors = require("catppuccin.palettes").get_palette("mocha")

vim.opt.list = true

vim.opt.listchars = {
    eol = "",
}

vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = colors.pink, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = colors.teal, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = colors.mauve, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = colors.sky, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = colors.red, nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = colors.sapphire, nocombine = true })

require("indent_blankline").setup({
    show_end_of_line = true,
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.g.indent_blankline_enabled = false end,
    desc = "Disable indent-blankline for OCaml files",
    group = group("DisableIndentOCaml"),
    pattern = "ocaml",
})
