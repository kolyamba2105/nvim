local local_options = {
  backup         = false,
  clipboard      = 'unnamed,unnamedplus',
  cmdheight      = 2,
  colorcolumn    = '80',
  completeopt    = 'menu,menuone,noselect',
  cursorcolumn   = true,
  cursorline     = true,
  emoji          = false,
  expandtab      = true,
  foldlevelstart = 99,
  guifont        = 'JetBrainsMono Nerd Font:h14',
  ignorecase     = true,
  laststatus     = 3,
  number         = true,
  relativenumber = true,
  scrolloff      = 16,
  shiftwidth     = 2,
  signcolumn     = 'yes:2',
  smartindent    = true,
  softtabstop    = 2,
  splitbelow     = true,
  splitright     = true,
  swapfile       = false,
  tabstop        = 2,
  termguicolors  = true,
  undofile       = true,
  updatetime     = 100,
  wildignore     = '*/tmp/*,*.so,*.swp,*.zip,*.svg,*.png,*.jpg,*.gif,node_modules',
  wrap           = false,
  writebackup    = false,
}

for k, v in pairs(local_options) do
  vim.opt[k] = v
end

local global_options = {
  mapleader = ' ',
  neovide_cursor_animation_length = 0.05,
  neovide_cursor_trail_size = 0.15,
  neovide_input_macos_alt_is_meta = true,
}

for k, v in pairs(global_options) do
  vim.g[k] = v
end
