return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            context_commentstring = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "comment",
                "css",
                "dockerfile",
                "fish",
                "graphql",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "kdl",
                "lua",
                "prisma",
                "scss",
                "toml",
                "tsx",
                "typescript",
                "yaml",
            },
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = false,
            },
            indent = {
                enable = true,
            },
        })

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "BufRead",
}
