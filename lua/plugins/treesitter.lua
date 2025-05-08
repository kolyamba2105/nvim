return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
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
                "groovy",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "kdl",
                "lua",
                "markdown",
                "prisma",
                "scss",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "vimdoc",
                "yaml",
            },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_file_size = 100 * 1024 -- 100 KB

                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                    return ok and stats and stats.size > max_file_size
                end,
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
    event = "BufRead",
}
