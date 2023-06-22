return {
    {
        "echasnovski/mini.ai",
        config = function() require("mini.ai").setup() end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.bracketed",
        config = function()
            local disable = { suffix = "" }

            -- stylua: ignore start
            require("mini.bracketed").setup({
                buffer =        disable,
                conflict =      disable,
                diagnostic =    { options = { severity = vim.diagnostic.severity.ERROR } },
                oldfile =       disable,
                quickfix =      disable,
                undo =          disable,
                yank =          disable,
            })
            -- stylua: ignore end
        end,
    },
    {
        "echasnovski/mini.bufremove",
        config = function()
            require("mini.bufremove").setup()

            vim.keymap.set("n", "<C-x>", require("mini.bufremove").delete, {
                desc = "Remove buffer",
                silent = true,
            })
        end,
    },
    {
        "echasnovski/mini.comment",
        config = function() require("mini.comment").setup() end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.cursorword",
        config = function()
            local colors = require("catppuccin.palettes").get_palette("mocha")
            local group = require("core.autocmds")

            require("mini.cursorword").setup({ delay = 500 })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function() vim.b.minicursorword_disable = true end,
                desc = "Disable cursorword in NvimTree",
                group = group("CursorWordDisableNvimTree"),
                pattern = "NvimTree",
            })

            vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1, fg = colors.green })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = colors.surface1, fg = colors.green })
        end,
        dependencies = {
            "catppuccin/nvim",
        },
        event = "BufRead",
    },
    {
        "echasnovski/mini.files",
        config = function()
            require("mini.files").setup()

            vim.keymap.set("n", "<C-n>", require("mini.files").open, {
                desc = "Open files",
                silent = true,
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.indentscope",
        config = function()
            local group = require("core.autocmds")

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
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.jump2d",
        config = function()
            require("mini.jump2d").setup({
                mappings = {
                    start_jumping = "<leader>j",
                },
                view = {
                    dim = true,
                },
            })
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.map",
        config = function()
            local group = require("core.autocmds")
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

            vim.keymap.set("n", "<leader>mc", mini_map.close, {
                desc = "Close",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mf", mini_map.toggle_focus, {
                desc = "Toggle focus",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mo", mini_map.open, {
                desc = "Open",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mr", mini_map.refresh, {
                desc = "Refresh",
                silent = true,
            })
            vim.keymap.set("n", "<leader>ms", mini_map.toggle_side, {
                desc = "Toggle side",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mt", mini_map.toggle, {
                desc = "Toggle",
                silent = true,
            })
        end,
        event = "BufReadPre",
    },
    {
        "echasnovski/mini.misc",
        config = function() require("mini.misc").setup() end,
    },
    {
        "echasnovski/mini.pairs",
        config = function() require("mini.pairs").setup() end,
    },
    {
        "echasnovski/mini.splitjoin",
        config = function() require("mini.splitjoin").setup() end,
    },
    {
        "echasnovski/mini.surround",
        config = function() require("mini.surround").setup() end,
    },
}
