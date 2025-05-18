return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>ga", "<cmd>Git add %<cr>", {
            desc = "Add (current file)",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", {
            desc = "Blame",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>", {
            desc = "Open fugitive pane",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gn", "<cmd>Git commit --no-verify<cr>", {
            desc = "Commit (--no-verify)",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", {
            desc = "Push",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gf", "<cmd>diffget //2<cr>", {
            desc = "Accept from left",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gj", "<cmd>diffget //3<cr>", {
            desc = "Accept from right",
            silent = true,
        })
    end,
}
