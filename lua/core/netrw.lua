local map = require("core.mappings")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.g.loaded_netrw ~= 1 then
    vim.g.netrw_banner = 0
    vim.g.netrw_list_hide = ".DS_Store"
    vim.g.netrw_winsize = 20

    map("n", "<leader>e", "<cmd>Ex<cr>")
end
