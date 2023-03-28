local map = require("core.mappings")

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
    },
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

map("n", "<C-b>", "<cmd>BufferLinePick<cr>")
