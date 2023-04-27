return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
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

        local map = require("core.mappings")
        local opts = { silent = true }

        map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opts)
        map("n", "<leader>gq", "<cmd>Gitsigns setqflist<cr>", opts)
        map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
        map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)
    end,
    event = "BufRead",
}
