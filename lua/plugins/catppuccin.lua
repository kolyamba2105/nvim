return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                mini = {
                    enabled = true,
                },
            },
            no_bold = true,
            no_italic = true,
            show_end_of_buffer = false,
        })

        vim.cmd.colorscheme("catppuccin")

        vim.api.nvim_set_hl(0, "@keyword.export", vim.api.nvim_get_hl(0, { name = "Keyword" }))
        vim.api.nvim_set_hl(0, "@keyword.operator", vim.api.nvim_get_hl(0, { name = "Keyword" }))
    end,
    name = "catppuccin",
    priority = 1000,
}
