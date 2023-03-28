return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                mini = true,
                nvimtree = false,
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
            vim.api.nvim_set_hl(
                0,
                hl,
                vim.tbl_extend("force", vim.api.nvim_get_hl_by_name(hl, {}), options)
            )
        end

        for setting, hls in pairs(groups) do
            for _, hl in pairs(hls) do
                update(hl, { [setting] = false })
            end
        end
    end,
    name = "catppuccin",
}
