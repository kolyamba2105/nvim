local map = require("user.core.mappings")

map("n", "<C-p>", "<cmd>PackerSync<cr>")

local is_packer_installed = function()
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", path })
    vim.cmd("packadd packer.nvim")

    return true
  end

  return false
end

local is_installed = is_packer_installed()

return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })

  use({ "catppuccin/nvim", as = "catppuccin", config = function() require("user.plugins.catppuccin") end })
  use({ "L3MON4D3/LuaSnip" })
  use({ "echasnovski/mini.nvim", config = function() require("user.plugins.mini") end })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/nvim-cmp", config = function() require("user.plugins.cmp") end })
  use({ "jose-elias-alvarez/typescript.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "lewis6991/gitsigns.nvim", config = function() require("user.plugins.gitsigns") end })
  use({ "lukas-reineke/indent-blankline.nvim", config = function() require("user.plugins.indent-blankline") end })
  use({ "neovim/nvim-lspconfig", config = function() require("user.plugins.lsp") end })
  use({ "nvim-lua/plenary.nvim" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lualine/lualine.nvim", config = function() require("user.plugins.lualine") end })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({ "nvim-telescope/telescope.nvim", config = function() require("user.plugins.telescope") end })
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function() require("user.plugins.treesitter") end,
    run = ":TSUpdate",
  })
  use({ "sitiom/nvim-numbertoggle" })
  use({ "tpope/vim-fugitive", config = function() require("user.plugins.fugitive") end })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-unimpaired" })

  if is_installed then require("packer").sync() end
end)
