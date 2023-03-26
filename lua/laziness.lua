local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    path,
  })
end

vim.opt.rtp:prepend(path)

require("lazy").setup({
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "L3MON4D3/LuaSnip" },
  { "catppuccin/nvim", name = "catppuccin", config = function() require("plugins.catppuccin") end },
  { "echasnovski/mini.nvim", config = function() require("plugins.mini") end },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/nvim-cmp", config = function() require("plugins.cmp") end },
  { "jose-elias-alvarez/typescript.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "lewis6991/gitsigns.nvim", config = function() require("plugins.gitsigns") end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require("plugins.indent-blankline") end },
  { "neovim/nvim-lspconfig", config = function() require("plugins.lsp") end },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lualine/lualine.nvim", config = function() require("plugins.lualine") end },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope.nvim", config = function() require("plugins.telescope") end },
  { "nvim-treesitter/nvim-treesitter", config = function() require("plugins.treesitter") end, build = ":TSUpdate" },
  { "sitiom/nvim-numbertoggle" },
  { "tpope/vim-fugitive", config = function() require("plugins.fugitive") end },
  { "tpope/vim-unimpaired" },
})
