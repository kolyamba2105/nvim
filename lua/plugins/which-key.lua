return {
    "folke/which-key.nvim",
    config = function()
        require("which-key").register({
            ["f"] = { name = "Telescope" },
            ["g"] = { name = "Git" },
            ["l"] = { name = "LSP" },
            ["m"] = { name = "Mini map" },
        }, { prefix = "<leader>" })
    end,
}
