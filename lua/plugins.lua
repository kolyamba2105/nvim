local map = require('mappings')

map('n', '<C-p>', '<cmd>PackerSync<cr>')

local is_packer_installed = function()
  local path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', path })
    vim.cmd('packadd packer.nvim')

    return true
  end

  return false
end

local is_installed = is_packer_installed()

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { "catppuccin/nvim", as = "catppuccin", config = function() require('user.catppuccin') end }
  use { 'L3MON4D3/LuaSnip' }
  use { 'echasnovski/mini.nvim', config = function() require('user.mini') end }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/nvim-cmp', config = function() require('user.cmp') end }
  use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'lewis6991/gitsigns.nvim', config = function() require('user.gitsigns') end }
  use { 'lukas-reineke/indent-blankline.nvim', config = function() require('user.indent-blankline') end }
  use { 'neovim/nvim-lspconfig', config = function() require('user.lsp') end }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lualine/lualine.nvim', config = function() require('user.lualine') end }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope.nvim', config = function() require('user.telescope') end }
  use { 'nvim-treesitter/nvim-treesitter', config = function() require('user.treesitter') end, run = ':TSUpdate' }
  use { 'sitiom/nvim-numbertoggle' }
  use { 'tpope/vim-fugitive', config = function() require('user.fugitive') end }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }

  if is_installed then require('packer').sync() end
end)
