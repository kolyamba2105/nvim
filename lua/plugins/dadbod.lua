return {
    "tpope/vim-dadbod",
    config = function()
        local group = require("core.autocmds")

        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function() vim.cmd.resize(32) end,
            desc = "Resize vim-dadbot output window",
            group = group("DadBodSplitSize"),
            pattern = "*.dbout",
        })
        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function() vim.b.minitrailspace_disable = true end,
            desc = "Disable mini.trailspace for vim-dadbod output window",
            group = group("DadBodDisableTrailSpace"),
            pattern = "*.dbout",
        })
    end,
}
