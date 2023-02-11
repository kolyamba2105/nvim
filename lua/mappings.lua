local map = vim.keymap.set

map("", "<leader>", "<Nop>")

-- Disable arrow keys
map({ "n", "i", "v" }, "<down>", "<Nop>")
map({ "n", "i", "v" }, "<left>", "<Nop>")
map({ "n", "i", "v" }, "<right>", "<Nop>")
map({ "n", "i", "v" }, "<up>", "<Nop>")

-- Move between windows (splits)
map("n", "<C-A-h>", "<cmd>wincmd h<cr>")
map("n", "<C-A-j>", "<cmd>wincmd j<cr>")
map("n", "<C-A-k>", "<cmd>wincmd k<cr>")
map("n", "<C-A-l>", "<cmd>wincmd l<cr>")

-- create splits
map("n", "<leader>h", "<cmd>sp<cr>")
map("n", "<leader>v", "<cmd>vsp<cr>")

-- Close current buffer/window
map("n", "<C-c>", "<cmd>close<cr>")
map("n", "<C-x>", "<cmd>bdelete<cr>")

-- Save file
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>W", "<cmd>wall<cr>")

-- Sort visually selected items
map("v", "<leader>s", ":sort<cr>")

-- Search for visually selected text
map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- Apply macros
map("n", "Q", "@q")
map("v", "Q", "<cmd>norm @q<cr>")

-- Paste and preserve copied data
map("x", "<leader>p", '"_dP')

return map
