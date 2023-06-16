vim.keymap.set("", "<leader>", "<nop>")

vim.keymap.set("n", "<leader>h", "<cmd>sp<cr>", {
    desc = "Create horizontal split",
})
vim.keymap.set("n", "<leader>v", "<cmd>vsp<cr>", {
    desc = "Create vertical split",
})
vim.keymap.set("n", "<C-c>", "<cmd>close<cr>", {
    desc = "Close buffer/window",
})
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {
    desc = "Save file",
})
vim.keymap.set("n", "<leader>W", "<cmd>wall<cr>", {
    desc = "Save all files",
})
vim.keymap.set("v", "<leader>s", ":sort<cr>", {
    desc = "Sort selected items",
})
vim.keymap.set("n", "Q", "@q", {
    desc = "Apply macro",
})
vim.keymap.set("v", "Q", ":norm @q<cr>", {
    desc = "Apply macro multiple times",
})
