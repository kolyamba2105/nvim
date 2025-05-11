return {
    "nvim-telescope/telescope.nvim",
    config = function()
        local telescope = require("telescope")
        local picker = require("plugins.telescope.picker")

        vim.keymap.set("n", "<leader>fa", picker("resume"), {
            desc = "Resume",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fb", picker("buffers"), {
            desc = "Buffers",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fc", picker("command_history"), {
            desc = "Command history",
            silent = true,
        })
        vim.keymap.set("n", "<leader>ff", picker("find_files"), {
            desc = "Find files",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fg", picker("live_grep"), {
            desc = "Live grep",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fh", picker("help_tags"), {
            desc = "Help tags",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fj", picker("jumplist"), {
            desc = "JumpList",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fm", picker("marks"), {
            desc = "Marks",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fq", picker("quickfix"), {
            desc = "QuickFix list",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fr", picker("grep_string"), {
            desc = "Grep string",
            silent = true,
        })
        vim.keymap.set("n", "<leader>fs", picker("search_history"), {
            desc = "Search history",
            silent = true,
        })
        vim.keymap.set("n", "<leader>ft", picker("treesitter"), {
            desc = "Treesitter",
            silent = true,
        })

        -- Git
        vim.keymap.set("n", "<leader>gl", picker("git_commits"), {
            desc = "Commits",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gr", picker("git_branches"), {
            desc = "Branches",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gs", picker("git_status"), {
            desc = "Status",
            silent = true,
        })
        vim.keymap.set("n", "<leader>gt", picker("git_stash"), {
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
                initial_mode = "insert",
                mappings = { i = mappings, n = mappings },
            }),
            extensions = {
                ["ui-select"] = require("telescope.themes").get_cursor({
                    initial_mode = "insert",
                }),
            },
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<c-x>"] = "delete_buffer",
                        },
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

        if vim.version.lt(vim.version(), "0.11.0") then return end

        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopeFindPre",
            callback = function()
                vim.opt.winborder = "none"

                vim.api.nvim_create_autocmd("WinLeave", {
                    once = true,
                    callback = function() vim.opt.winborder = "double" end,
                })
            end,
        })
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
}
