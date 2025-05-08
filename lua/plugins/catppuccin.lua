local function update(hl, options)
    vim.api.nvim_set_hl(0, hl, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = hl }), options))
end

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

        update("@keyword.export", vim.api.nvim_get_hl(0, { name = "Keyword" }))
        update("@keyword.operator", vim.api.nvim_get_hl(0, { name = "Keyword" }))
    end,
    name = "catppuccin",
    priority = 1000,
}
