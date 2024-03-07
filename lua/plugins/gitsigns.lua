return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            attach_to_untracked = true,
            signs = {
                add = {
                    hl = "GitSignsAdd",
                    linehl = "GitSignsAddLn",
                    numhl = "GitSignsAddNr",
                    text = "+",
                },
                change = {
                    hl = "GitSignsChange",
                    linehl = "GitSignsChangeLn",
                    numhl = "GitSignsChangeNr",
                    text = "~",
                },
                delete = {
                    hl = "GitSignsDelete",
                    linehl = "GitSignsDeleteLn",
                    numhl = "GitSignsDeleteNr",
                    text = "-",
                },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "‾",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                changedelete = {
                    hl = "GitSignsChange",
                    linehl = "GitSignsChangeLn",
                    numhl = "GitSignsChangeNr",
                    text = "_",
                },
            },
            numhl = true,
        })

        vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", {
            desc = "Go to previous hunk",
            silent = true,
        })
        vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", {
            desc = "Go to next hunk",
            silent = true,
        })
        vim.keymap.set("n", "<leader>b", "<cmd>Gitsigns toggle_current_line_blame<cr>", {
            desc = "Toggle current line blame",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", {
            desc = "Show diff",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gq", "<cmd>Gitsigns setqflist<cr>", {
            desc = "Set quick-fix list",
            silent = true,
        })
        vim.keymap.set("v", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", {
            desc = "Reset hunk",
            silent = true,
        })
        vim.keymap.set("v", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", {
            desc = "Stage hunk",
            silent = true,
        })
    end,
    event = "BufRead",
}
