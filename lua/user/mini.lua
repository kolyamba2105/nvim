require("mini.bufremove").setup()
require("mini.comment").setup()
require("mini.misc").setup()
require("mini.pairs").setup()

-- Cursor word
vim.api.nvim_create_autocmd("Filetype", {
  group = vim.api.nvim_create_augroup("cursorword_disable", { clear = false }),
  desc = "Disable cursorword in NvimTree",
  pattern = "NvimTree",
  callback = function() vim.b.minicursorword_disable = true end,
})

require("mini.cursorword").setup({ delay = 500 })

vim.api.nvim_set_hl(0, "MiniCursorword", { bg = "#45475a", fg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "#45475a", fg = "#a6e3a1" })
