return {
    "echasnovski/mini.nvim",
    config = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        local group = require("core.autocmds")
        local map = require("core.mappings")

        -- AI
        require("mini.ai").setup()

        -- Bracketed
        local disable = { suffix = "" }

        -- stylua: ignore start
        require("mini.bracketed").setup({
          buffer      = disable,
          conflict    = disable,
          diagnostic  = { options = { severity = vim.diagnostic.severity.ERROR } },
          oldfile     = disable,
          quickfix    = disable,
          undo        = disable,
          yank        = disable,
        })
        -- stylua: ignore end

        -- Bufremove
        require("mini.bufremove").setup()

        map("n", "<C-x>", require("mini.bufremove").delete)

        -- Comment
        require("mini.comment").setup()

        -- Cursor word
        require("mini.cursorword").setup({ delay = 500 })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function() vim.b.minicursorword_disable = true end,
            desc = "Disable cursorword in NvimTree",
            group = group("CursorWordDisableNvimTree"),
            pattern = "NvimTree",
        })

        vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1, fg = colors.green })
        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = colors.surface1, fg = colors.green })

        -- Indentscope
        require("mini.indentscope").setup({
            draw = {
                delay = 0,
                animation = function() return 0 end,
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Disable mini.indentscope except for OCaml files",
            pattern = "*",
            group = group("DisableMiniIndentScope"),
            callback = function()
                if vim.bo.filetype ~= "ocaml" then vim.b.miniindentscope_disable = true end
            end,
        })

        -- Jump2d
        require("mini.jump2d").setup()

        -- Map
        local mini_map = require("mini.map")

        mini_map.setup({
            integrations = {
                mini_map.gen_integration.builtin_search(),
                mini_map.gen_integration.diagnostic(),
                mini_map.gen_integration.gitsigns(),
            },
            symbols = {
                encode = mini_map.gen_encode_symbols.dot("3x2"),
                scroll_line = "▶",
                scroll_view = "┃",
            },
            window = {
                show_integration_count = false,
                winblend = 75,
            },
        })

        vim.api.nvim_create_autocmd("BufRead", {
            desc = "Open mini-map on BufRead",
            pattern = "*",
            group = group("OpenMiniMap"),
            callback = mini_map.open,
        })

        map("n", "<leader>mc", mini_map.close)
        map("n", "<leader>mf", mini_map.toggle_focus)
        map("n", "<leader>mo", mini_map.open)
        map("n", "<leader>mr", mini_map.refresh)
        map("n", "<leader>ms", mini_map.toggle_side)
        map("n", "<leader>mt", mini_map.toggle)

        -- Misc
        require("mini.misc").setup()

        -- Pairs
        require("mini.pairs").setup()

        -- SplitJoin
        require("mini.splitjoin").setup()

        -- Surround
        require("mini.surround").setup()
    end,
    dependencies = {
        "catppuccin/nvim",
    },
    event = "BufReadPre",
}
