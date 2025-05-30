--- options

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

--- mappings

vim.keymap.set("n", "<leader>h", "<cmd>sp<cr>", {
    desc = "Create horizontal split",
})
vim.keymap.set("n", "<leader>v", "<cmd>vsp<cr>", {
    desc = "Create vertical split",
})
vim.keymap.set("n", "<C-c>", "<cmd>close<cr>", {
    desc = "Close buffer/window",
})
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {
    desc = "Save file",
})
vim.keymap.set("n", "<leader>W", "<cmd>wall<cr>", {
    desc = "Save all files",
})
vim.keymap.set("v", "<leader>s", ":sort<cr>", {
    desc = "Sort selected items",
})
vim.keymap.set("n", "Q", "@q", {
    desc = "Apply macro",
})
vim.keymap.set("v", "Q", ":norm @q<cr>", {
    desc = "Apply macro multiple times",
})

--- commands

vim.api.nvim_create_user_command("CopyBufferPath", function()
    local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":." .. vim.fn.getcwd())

    vim.fn.setreg("+", file_name)
    print(string.format("Copied: %s", file_name))
end, { desc = "Copy current buffer path" })

--- auto-commands

local function group(name) return vim.api.nvim_create_augroup(name, { clear = false }) end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.colorcolumn = "120"
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
        vim.opt.tabstop = 4
    end,
    desc = "Set Vim settings for Lua files",
    group = group("LuaEditorSettings"),
    pattern = {
        "lua",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.opt.textwidth = 80 end,
    desc = "Set editor options for *.md files",
    group = group("MarkDownOptions"),
    pattern = {
        "markdown",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.cmd("compiler tsc | setlocal makeprg=npx\\ tsc")

        vim.keymap.set("n", "<leader>lc", "<cmd>make<cr>", {
            desc = "Run TypeScript compiler",
        })
    end,
    desc = "Set compiler options for TypeScript files",
    group = group("TypeScriptOptions"),
    pattern = {
        "typescript",
        "typescript.tsx",
        "typescriptreact",
    },
})

--- prettier config

local filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "jsonc",
    "markdown",
    "scss",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local value = tonumber(vim.fn.system("prettier-output-config printWidth"))

        if value ~= nil then vim.cmd("setlocal colorcolumn=" .. value) end
    end,
    desc = "Set colorcolumn based on Prettier printWidth",
    group = group("PrettierOutputConfigPrintWidth"),
    pattern = filetypes,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local value = tonumber(vim.fn.system("prettier-output-config tabWidth"))

        if value ~= nil then
            vim.cmd("setlocal shiftwidth=" .. value)
            vim.cmd("setlocal softtabstop=" .. value)
            vim.cmd("setlocal tabstop=" .. value)
        end
    end,
    desc = "Set tab width based on Prettier tabWidth",
    group = group("PettierOutputConfigTabWidth"),
    pattern = filetypes,
})
