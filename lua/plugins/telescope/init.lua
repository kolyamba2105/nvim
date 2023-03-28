return {
    "nvim-telescope/telescope.nvim",
    config = function()
        local map = require("core.mappings")
        local telescope = require("telescope")
        local utils = require("plugins.telescope.utils")

        local opts = { silent = true }

        map("n", "<C-p>", "<cmd>Telescope builtin initial_mode=insert<cr>", opts)

        map("n", "<leader>fa", utils.get_picker("resume"), opts)
        map("n", "<leader>fb", utils.get_picker("buffers"), opts)
        map("n", "<leader>fc", utils.get_picker("command_history"), opts)
        map("n", "<leader>ff", utils.get_picker_insert("find_files"), opts)
        map("n", "<leader>fg", utils.get_picker_insert("live_grep"), opts)
        map("n", "<leader>fh", utils.get_picker_insert("help_tags"), opts)
        map("n", "<leader>fj", utils.get_picker("jumplist"), opts)
        map("n", "<leader>fm", utils.get_picker("marks"), opts)
        map("n", "<leader>fq", utils.get_picker("quickfix"), opts)
        map("n", "<leader>fr", utils.get_picker("grep_string"), opts)
        map("n", "<leader>fs", utils.get_picker_insert("search_history"), opts)

        -- Git
        map("n", "<leader>gc", utils.get_picker("git_commits"), opts)
        map("n", "<leader>gr", utils.get_picker("git_branches"), opts)
        map("n", "<leader>gs", utils.get_picker("git_status"), opts)
        map("n", "<leader>gt", utils.get_picker("git_stash"), opts)

        -- File browser
        local function file_browser_cwd()
            return telescope.extensions.file_browser.file_browser({
                cwd = vim.fn.expand("%:p:h"),
            })
        end

        map("n", "<C-n>", telescope.extensions.file_browser.file_browser, opts)
        map("n", "<C-e>", file_browser_cwd, opts)

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
                initial_mode = "normal",
                mappings = { i = mappings, n = mappings },
            }),
            extensions = {
                file_browser = {
                    grouped = true,
                    hidden = true,
                    initial_mode = "normal",
                },
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
                file_browser = {
                    hidden = true,
                },
            },
        })

        telescope.load_extension("file_browser")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
}
