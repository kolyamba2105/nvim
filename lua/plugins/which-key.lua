return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")

        wk.setup()

        wk.register({
            ["<leader>f"] = { name = "Telescope" },
            ["<leader>g"] = { name = "Git" },
            ["<leader>l"] = { name = "LSP" },
            ["<leader>m"] = { name = "Mini map" },
        })
    end,
}
