return {
    "nvim-telescope/telescope.nvim",
    config = function()
        local telescope = require("telescope")
        local utils = require("plugins.telescope.utils")

        vim.keymap.set("n", "<C-p>", "<cmd>Telescope builtin initial_mode=insert<cr>", {
            desc = "Built-in pickers",
            silent = true,
        })

        vim.keymap.set("n", "<leader>fa", utils.get_picker("resume"), {
            desc = "Resume",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fb", utils.get_picker("buffers"), {
            desc = "Buffers",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fc", utils.get_picker("command_history"), {
            desc = "Command history",
            silent = true,
        })
        vim.keymap.set("n", "<leader>ff", utils.get_picker_insert("find_files"), {
            desc = "Find files",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fg", utils.get_picker_insert("live_grep"), {
            desc = "Live grep",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fh", utils.get_picker_insert("help_tags"), {
            desc = "Help tags",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fj", utils.get_picker("jumplist"), {
            desc = "JumpList",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fm", utils.get_picker("marks"), {
            desc = "Marks",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fq", utils.get_picker("quickfix"), {
            desc = "QuickFix list",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fr", utils.get_picker("grep_string"), {
            desc = "Grep string",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fs", utils.get_picker_insert("search_history"), {
            desc = "Search history",
            silent = true,
        })

        -- Git
        vim.keymap.set("n", "<leader>gc", utils.get_picker("git_commits"), {
            desc = "Commits",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gr", utils.get_picker("git_branches"), {
            desc = "Branches",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gs", utils.get_picker("git_status"), {
            desc = "Status",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gt", utils.get_picker("git_stash"), {
            desc = "Stash",
            silent = true,
        })

        local mappings = {
            ["<c-h>"] = require("telescope.actions").file_split,
            ["<c-x>"] = false,
            ["<c-q>"] = function(bufnr)
                require("telescope.actions").smart_send_to_qflist(bufnr)
                require("telescope.builtin").quickfix()
            end,
        }

        telescope.setup({
            defaults = require("telescope.themes").get_ivy({
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                initial_mode = "normal",
                mappings = { i = mappings, n = mappings },
            }),
            extensions = {
                ["ui-select"] = {
                    initial_mode = "normal",
                },
            },
            pickers = {
                buffers = {
                    mappings = {
                        n = {
                            ["<c-x>"] = "delete_buffer",
                        },
                    },
                },
                find_files = {
                    hidden = true,
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
}
