local map = require("core.mappings")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  git = {
    ignore = false,
  },
  view = {
    width = 50,
  },
})

map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
map("n", "<C-f>", "<cmd>NvimTreeFindFile<cr>")
