return {
    {
        "echasnovski/mini.ai",
        config = function() require("mini.ai").setup() end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.basics",
        config = function()
            require("mini.basics").setup({
                autocommands = {
                    relnum_in_visual_mode = true,
                },
                mappings = {
                    windows = false,
                },
                options = {
                    win_borders = vim.g.neovide and "single" or "double",
                },
            })
        end,
    },
    {
        "echasnovski/mini.bracketed",
        config = function()
            require("mini.bracketed").setup({
                diagnostic = { options = { severity = vim.diagnostic.severity.ERROR } },
            })
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
        "echasnovski/mini.clue",
        config = function()
            local clue = require("mini.clue")

            clue.setup({
                clues = {
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.windows(),
                    clue.gen_clues.z(),

                    {
                        desc = "Telescope",
                        keys = "<Leader>f",
                        mode = "n",
                    },
                    {
                        desc = "Git",
                        keys = "<Leader>g",
                        mode = "n",
                    },
                    {
                        desc = "LSP",
                        keys = "<Leader>l",
                        mode = "n",
                    },
                    {
                        desc = "Mini map",
                        keys = "<Leader>m",
                        mode = "n",
                    },
                    {
                        desc = "Mini visits",
                        keys = "<Leader>a",
                        mode = "n",
                    },
                },
                triggers = {
                    { keys = "<C-w>", mode = "n" },
                    { keys = "<C-x>", mode = "i" },
                    { keys = "<Leader>", mode = "n" },
                    { keys = "<Leader>", mode = "x" },
                    { keys = "[", mode = "n" },
                    { keys = "[", mode = "x" },
                    { keys = "]", mode = "n" },
                    { keys = "]", mode = "x" },
                    { keys = "g", mode = "n" },
                    { keys = "g", mode = "x" },
                    { keys = "z", mode = "n" },
                    { keys = "z", mode = "x" },
                },
                window = {
                    delay = 1000,
                },
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.completion",
        config = function()
            require("mini.completion").setup({
                delay = { completion = 50, info = 50, signature = 50 },
                lsp_completion = {
                    process_items = require("mini.fuzzy").process_lsp_items,
                },
                window = { info = { border = "double" }, signature = { border = "double" } },
            })
        end,
        dependencies = {
            "echasnovski/mini.fuzzy",
        },
        event = "VeryLazy",
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

            require("mini.cursorword").setup({ delay = 1000 })

            vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1, fg = colors.peach })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = colors.surface1, fg = colors.peach })
        end,
        dependencies = {
            "catppuccin/nvim",
        },
        event = "BufRead",
    },
    {
        "echasnovski/mini.diff",
        config = function()
            require("mini.diff").setup({
                options = {
                    wrap_goto = true,
                },
                view = {
                    priority = 0,
                    signs = { add = "+", change = "~", delete = "-" },
                    style = "sign",
                },
            })

            vim.keymap.set("n", "<leader>gd", require("mini.diff").toggle_overlay, {
                desc = "Show diff",
                silent = true,
            })
        end,
    },
    {
        "echasnovski/mini.files",
        config = function()
            require("mini.files").setup({
                content = {
                    filter = function(entry) return entry.name ~= ".DS_Store" end,
                },
                windows = {
                    width_focus = 50,
                    width_nofocus = 25,
                },
            })

            vim.keymap.set("n", "_", require("mini.files").open, {
                desc = "Open mini.files",
                silent = true,
            })
            vim.keymap.set("n", "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, {
                desc = "Open mini.files (cwd)",
                silent = true,
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.fuzzy",
        config = function() require("mini.fuzzy").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.hipatterns",
        config = function()
            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.icons",
        config = function()
            require("mini.icons").setup()

            require("mini.icons").mock_nvim_web_devicons()
            require("mini.icons").tweak_lsp_kind()
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.indentscope",
        config = function()
            require("mini.indentscope").setup({
                draw = {
                    delay = 10,
                    animation = function() return 10 end,
                },
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
            local MiniMap = require("mini.map")

            MiniMap.setup({
                integrations = {
                    MiniMap.gen_integration.builtin_search(),
                    MiniMap.gen_integration.diagnostic(),
                    MiniMap.gen_integration.diff(),
                },
                symbols = {
                    encode = MiniMap.gen_encode_symbols.dot("3x2"),
                    scroll_line = "▶",
                    scroll_view = "┃",
                },
                window = {
                    show_integration_count = false,
                    winblend = 75,
                },
            })

            vim.keymap.set("n", "<leader>mc", MiniMap.close, {
                desc = "Close",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mf", MiniMap.toggle_focus, {
                desc = "Toggle focus",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mo", MiniMap.open, {
                desc = "Open",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mr", MiniMap.refresh, {
                desc = "Refresh",
                silent = true,
            })
            vim.keymap.set("n", "<leader>ms", MiniMap.toggle_side, {
                desc = "Toggle side",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mt", MiniMap.toggle, {
                desc = "Toggle",
                silent = true,
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.misc",
        config = function() require("mini.misc").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.move",
        config = function()
            require("mini.move").setup({
                mappings = {
                    -- stylua: ignore start
                    left        = "<S-left>",
                    right       = "<S-right>",
                    down        = "<S-down>",
                    up          = "<S-up>",
                    line_left   = "<S-left>",
                    line_right  = "<S-right>",
                    line_down   = "<S-down>",
                    line_up     = "<S-up>",
                    -- stylua: ignore end
                },
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.notify",
        config = function()
            require("mini.notify").setup({
                content = {
                    format = function(notification)
                        local time = vim.fn.strftime("%H:%M:%S", math.floor(notification.ts_update))

                        return string.format("%s -> %s", time, notification.msg)
                    end,
                },
                window = {
                    config = {
                        border = "double",
                    },
                },
            })

            vim.notify = require("mini.notify").make_notify()
        end,
        enabled = false,
    },
    {
        "echasnovski/mini.operators",
        config = function() require("mini.operators").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.pairs",
        config = function() require("mini.pairs").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.splitjoin",
        config = function() require("mini.splitjoin").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.statusline",
        config = function()
            local MiniStatusline = require("mini.statusline")

            MiniStatusline.setup({
                content = {
                    active = function()
                        -- stylua: ignore start
                        local diagnostics       = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local diff              = MiniStatusline.section_diff({ trunc_width = 75 })
                        local fileinfo          = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local filename          = MiniStatusline.section_filename({ trunc_width = 140 })
                        local git               = MiniStatusline.section_git({ trunc_width = 40 })
                        local lsp               = MiniStatusline.section_lsp({ trunc_width = 75 })
                        local mode, mode_hl     = MiniStatusline.section_mode({ trunc_width = 120 })
                        local search            = MiniStatusline.section_searchcount({ trunc_width = 75 })
                        -- stylua: ignore start

                        return MiniStatusline.combine_groups({
                            {
                                hl = mode_hl,
                                strings = { mode },
                            },
                            {
                                hl = "MiniStatuslineDevinfo",
                                strings = { git, diff, diagnostics, lsp },
                            },
                            "%<",
                            {
                                hl = "MiniStatuslineFilename",
                                strings = { filename },
                            },
                            "%=",
                            {
                                hl = "MiniStatuslineFileinfo",
                                strings = { fileinfo },
                            },
                            {
                                hl = mode_hl,
                                strings = {
                                    search,
                                    MiniStatusline.is_truncated(75) and "%l:%2v" or '%l:%L %2v:%-2{virtcol("$") - 1}',
                                },
                            },
                        })
                    end,
                },
                set_vim_settings = false,
            })
        end,
        enabled = false,
    },
    {
        "echasnovski/mini.surround",
        config = function() require("mini.surround").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.tabline",
        config = function()
            require("mini.tabline").setup()

            vim.api.nvim_create_user_command("ToggleTabLine", function()
                if vim.g.minitabline_disable then
                    vim.opt.showtabline = 2
                    vim.g.minitabline_disable = false

                    MiniTabline.setup()
                else
                    vim.opt.showtabline = 0
                    vim.g.minitabline_disable = true
                end
            end, { desc = "Toggle TabLine" })
        end,
    },
    {
        "echasnovski/mini.trailspace",
        config = function() require("mini.trailspace").setup() end,
    },
    {
        "echasnovski/mini.visits",
        config = function()
            local visits = require("mini.visits")

            visits.setup()

            vim.keymap.set("n", "<leader>as", visits.select_path, {
                desc = "Select path",
                silent = true,
            })
        end,
    },
}
