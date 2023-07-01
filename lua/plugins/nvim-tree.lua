return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local function make_view()
            local ratio = { width = 0.4, height = 0.8 }

            return {
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen = {
                            width = vim.opt.columns:get(),
                            height = vim.opt.lines:get() - vim.opt.cmdheight:get(),
                        }
                        local window = {
                            width = screen.width * ratio.width,
                            height = screen.height * ratio.height,
                        }

                        local width = math.floor(window.width)
                        local height = math.floor(window.height)

                        local col = (screen.width - window.width) / 2
                        local row = ((vim.opt.lines:get() - window.height) / 2) - vim.opt.cmdheight:get()

                        return {
                            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                            col = col,
                            height = height,
                            relative = "editor",
                            row = row,
                            width = width,
                        }
                    end,
                },
                width = function() return math.floor(vim.opt.columns:get() * ratio.width) end,
            }
        end

        require("nvim-tree").setup({
            disable_netrw = true,
            git = { ignore = false },
            hijack_cursor = true,
            modified = {
                enable = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            view = make_view(),
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", {
            desc = "Open nvim-tree",
            silent = true,
        })
    end,
}
