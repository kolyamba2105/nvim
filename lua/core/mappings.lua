local map = vim.keymap.set

map("", "<leader>", "<Nop>")

-- create splits
map("n", "<leader>h", "<cmd>sp<cr>")
map("n", "<leader>v", "<cmd>vsp<cr>")

-- Close current buffer/window
map("n", "<C-b>", "<cmd>bdelete<cr>")
map("n", "<C-c>", "<cmd>close<cr>")

-- Save file
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>W", "<cmd>wall<cr>")

-- Sort visually selected items
map("v", "<leader>s", ":sort<cr>")

-- Apply macros
map("n", "Q", "@q")
map("v", "Q", "<cmd>norm @q<cr>")

return map
