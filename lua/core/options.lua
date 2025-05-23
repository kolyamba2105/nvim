local local_options = {
    backup = false,
    clipboard = "unnamed,unnamedplus",
    cmdheight = 2,
    colorcolumn = "80",
    completeopt = "menuone,noselect,fuzzy",
    cursorline = true,
    emoji = false,
    expandtab = true,
    foldlevel = 99,
    foldlevelstart = 99,
    guifont = "JetBrainsMono Nerd Font:h14",
    ignorecase = true,
    laststatus = 3,
    number = true,
    scrolloff = 16,
    shiftwidth = 2,
    signcolumn = "yes",
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    undofile = true,
    updatetime = 100,
    wildignore = "*/tmp/*,*.so,*.swp,*.zip,*.svg,*.png,*.jpg,*.gif,node_modules",
    wrap = false,
    writebackup = false,
}

for k, v in pairs(local_options) do
    vim.opt[k] = v
end

local local_options_next = {
    winborder = "double",
}

if vim.version.ge(vim.version(), "0.11.0") then
    for k, v in pairs(local_options_next) do
        vim.opt[k] = v
    end
end

local global_options = {
    mapleader = " ",
    maplocalleader = " ",
}

local neovide_options = {
    neovide_cursor_animation_length = 0.05,
    neovide_cursor_trail_size = 0.1,
    neovide_cursor_vfx_mode = "sonicboom",
    neovide_input_macos_alt_is_meta = true,
    neovide_padding_bottom = 12,
    neovide_padding_left = 24,
    neovide_padding_right = 24,
    neovide_padding_top = 12,
    neovide_scroll_animation_length = 0.3,
}

local options = vim.g.neovide and vim.tbl_extend("keep", neovide_options, global_options) or global_options

for k, v in pairs(options) do
    vim.g[k] = v
end
