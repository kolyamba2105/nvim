require('catppuccin').setup {
  flavour = 'mocha',
  integrations = {
    nvimtree = false,
  },
}

vim.cmd [[ colorscheme catppuccin ]]

vim.api.nvim_set_hl(0, "@conditional", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "@namespace", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "@parameter", { fg = "#eba0ac" })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#94e2d5" })
vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#eba0ac" })
