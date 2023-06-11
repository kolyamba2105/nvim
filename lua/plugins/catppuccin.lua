return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                mini = true,
            },
        })

        vim.cmd("colorscheme catppuccin")

        local groups = {
            bold = {
                "@keyword.export",
            },
            italic = {
                "@conditional",
                "@namespace",
                "@parameter",
                "@tag.attribute",
                "@tag.attribute.tsx",
                "@text.emphasis",
            },
        }

        local function update(hl, options)
            vim.api.nvim_set_hl(0, hl, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = hl }), options))
        end

        for setting, hls in pairs(groups) do
            for _, hl in pairs(hls) do
                update(hl, { [setting] = false })
            end
        end

        update("@keyword.export", vim.api.nvim_get_hl(0, { name = "Keyword" }))
    end,
    name = "catppuccin",
}
