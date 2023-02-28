local map = require("core.mappings")

-- AI
require("mini.ai").setup()

-- Bracketed
local disable = { suffix = "" }

-- stylua: ignore start
require("mini.bracketed").setup({
  buffer      = disable,
  conflict    = disable,
  diagnostic  = { options = { severity = vim.diagnostic.severity.ERROR } },
  oldfile     = disable,
  quickfix    = disable,
  undo        = disable,
  yank        = disable,
})
-- stylua: ignore end

-- Bufremove
require("mini.bufremove").setup()

map("n", "<C-x>", require("mini.bufremove").delete)

-- Comment
require("mini.comment").setup()

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

-- Indentscope
require("mini.indentscope").setup({
  draw = {
    delay = 0,
    animation = function() return 0 end,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable mini.indentscope except for OCaml files",
  pattern = "*",
  group = vim.api.nvim_create_augroup("DisableMiniIndentScope", { clear = true }),
  callback = function()
    if vim.bo.filetype ~= "ocaml" then vim.b.miniindentscope_disable = true end
  end,
})

-- Misc
require("mini.misc").setup()

-- Pairs
require("mini.pairs").setup()

-- Surround
require("mini.surround").setup()
