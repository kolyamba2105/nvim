return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'L3MON4D3/LuaSnip' }
  use { 'ggandor/lightspeed.nvim' }
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
  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    require('user.indent-blankline')
  end }
  use { 'neovim/nvim-lspconfig', config = function()
    require('user.lsp')
  end }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lualine/lualine.nvim', config = function()
    require('user.lualine')
  end }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope.nvim', config = function()
    require('user.telescope')
  end }
  use { 'nvim-treesitter/nvim-treesitter', config = function()
    require('user.treesitter')
  end, run = ':TSUpdate' }
  use { 'sainnhe/gruvbox-material', config = function()
    vim.cmd('colorscheme gruvbox-material')
  end }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive', config = function()
    require('user.fugitive')
  end }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
  use { 'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup()
  end }
end)
