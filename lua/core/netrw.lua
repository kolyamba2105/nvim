local map = require("core.mappings")

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = ".DS_Store"
vim.g.netrw_winsize = 20

map("n", "<leader>e", "<cmd>Ex<cr>")
