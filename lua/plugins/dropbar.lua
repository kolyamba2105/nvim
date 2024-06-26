return {
    {
        "Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        enabled = false,
        opts = {
            bar = {
                padding = {
                    left = 6,
                },
            },
            win_configs = {
                border = vim.g.neovide and "single" or "double",
            },
        },
    },
}
