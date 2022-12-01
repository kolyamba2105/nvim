return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'L3MON4D3/LuaSnip' }
  use { 'echasnovski/mini.nvim', config = function()
    require('user.mini')
  end }
  use { "catppuccin/nvim", as = "catppuccin", config = function()
    require('user.catppuccin')
  end }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/nvim-cmp', config = function()
    require('user.cmp')
  end }
  use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'lewis6991/gitsigns.nvim', config = function()
    require('user.gitsigns')
  end }
  use { 'nvim-lualine/lualine.nvim', config = function()
    require('user.lualine')
  end }
  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    require('user.indent-blankline')
  end }
  use { 'neovim/nvim-lspconfig', config = function()
    require('user.lsp')
  end }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope.nvim', config = function()
    require('user.telescope')
  end }
  use { 'nvim-treesitter/nvim-treesitter', config = function()
    require('user.treesitter')
  end, run = ':TSUpdate' }
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', }, tag = 'nightly', config = function()
    require('user.nvim-tree')
  end }
  use { "nvim-zh/colorful-winsep.nvim", config = function()
    require('colorful-winsep').setup()
  end }
  use { 'tpope/vim-fugitive', config = function()
    require('user.fugitive')
  end }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
end)
