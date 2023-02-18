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
  { "catppuccin/nvim", as = "catppuccin", config = function() require("user.plugins.catppuccin") end },
  { "L3MON4D3/LuaSnip" },
  { "echasnovski/mini.nvim", config = function() require("user.plugins.mini") end },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/nvim-cmp", config = function() require("user.plugins.cmp") end },
  { "jose-elias-alvarez/typescript.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "lewis6991/gitsigns.nvim", config = function() require("user.plugins.gitsigns") end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require("user.plugins.indent-blankline") end },
  { "neovim/nvim-lspconfig", config = function() require("user.plugins.lsp") end },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lualine/lualine.nvim", config = function() require("user.plugins.lualine") end },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope.nvim", config = function() require("user.plugins.telescope") end },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function() require("user.plugins.treesitter") end,
    build = ":TSUpdate",
  },
  { "sitiom/nvim-numbertoggle" },
  { "tpope/vim-fugitive", config = function() require("user.plugins.fugitive") end },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },
})
