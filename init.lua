--- @diagnostic disable: duplicate-doc-field

--- options

local local_options = {
    backup = false,
    clipboard = "unnamed,unnamedplus",
    cmdheight = 2,
    confirm = true,
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
    winborder = "double",
    wrap = false,
    writebackup = false,
}

for k, v in pairs(local_options) do
    vim.opt[k] = v
end

local global_options = {
    mapleader = " ",
    maplocalleader = " ",
}

for k, v in pairs(global_options) do
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
        vim.wo.colorcolumn = "120"
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
        vim.bo.tabstop = 4
    end,
    desc = "Set Vim settings for Lua files",
    group = group("LuaEditorSettings"),
    pattern = {
        "lua",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.cmd.compiler("tsc")

        vim.bo.makeprg = "npx tsc -b"

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

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local print = tostring(tonumber(vim.fn.system("prettier-output-config printWidth")))
        local tab = tonumber(vim.fn.system("prettier-output-config tabWidth")) or 2

        vim.wo.colorcolumn = print
        vim.bo.shiftwidth = tab
        vim.bo.softtabstop = tab
        vim.bo.tabstop = tab
    end,
    desc = "Set editor settings based on prettier-output-config",
    group = group("PrettierEditorSettings"),
    pattern = {
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
    },
})

--- plugin manager setup

local repo = "https://github.com/folke/lazy.nvim.git"

local path = string.format("%s/lazy/lazy.nvim", vim.fn.stdpath("data"))

--- @diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(path) then
    vim.fn.system({ "git", "clone", "--branch=stable", "--filter=blob:none", repo, path })
end

vim.opt.rtp:prepend(path)

--- telescope utils

--- @param name string
--- @param options? { [string]: unknown }
local function picker(name, options)
    return function()
        return require("telescope.builtin")[name](vim.tbl_extend("force", { initial_mode = "insert" }, options or {}))
    end
end

--- lsp utils

local function on_attach(_, buffer)
    vim.keymap.set("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, {
        buffer = buffer,
        desc = "Go to next diagnostic",
        silent = true,
    })
    vim.keymap.set("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, {
        buffer = buffer,
        desc = "Go to prev diagnostic",
        silent = true,
    })
    vim.keymap.set(
        "n",
        "<leader>k",
        function() vim.lsp.buf.hover({ close_events = { "BufHidden", "CursorMoved" } }) end,
        {
            buffer = buffer,
            desc = "Hover",
            silent = true,
        }
    )
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
        buffer = buffer,
        desc = "Code action",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ld", picker("lsp_definitions"), {
        buffer = buffer,
        desc = "Definitions",
        silent = true,
    })
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, {
        buffer = buffer,
        desc = "Open diagnostic float",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {
        buffer = buffer,
        desc = "Toggle inlay hints",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ll", picker("diagnostics"), {
        buffer = buffer,
        desc = "Diagnostics",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {
        buffer = buffer,
        desc = "Rename",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, {
        buffer = buffer,
        desc = "Set location list",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lr", picker("lsp_references"), {
        buffer = buffer,
        desc = "References",
        silent = true,
    })
    vim.keymap.set("n", "<leader>ls", picker("lsp_document_symbols"), {
        buffer = buffer,
        desc = "Document symbols",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lt", picker("lsp_type_definitions"), {
        buffer = buffer,
        desc = "Type definitions",
        silent = true,
    })
    vim.keymap.set("n", "<leader>lw", picker("lsp_dynamic_workspace_symbols"), {
        buffer = buffer,
        desc = "Dynamic workspace symbols",
        silent = true,
    })
end

--- @class Entry
--- @field priority number
--- @field path string

--- @param entries Entry[]
--- @return string | nil
local function executable_path(entries)
    table.sort(entries, function(a, b) return a.priority > b.priority end)

    for _, entry in ipairs(entries) do
        if vim.fn.filereadable(entry.path) ~= 0 then return entry.path end
    end

    return nil
end

--- project-specific config

--- @param path string
--- @diagnostic disable-next-line: redefined-local
local function read_json_file(path)
    local file = io.open(path, "r")

    if not file then error("Unable to open a file: " .. path) end

    local json = file:read("a")

    file:close()

    return vim.json.decode(json)
end

--- @param file_path string
local function normalise_file_path(file_path) return file_path:gsub("^~", vim.fn.expand("~")) end

--- @param file_path string
--- @param directory string
local function is_inside_of_directory(file_path, directory) return file_path:sub(1, #directory) == directory end

--- @type table<integer, string>
local disable_format_on_save = vim.tbl_map(
    normalise_file_path,
    read_json_file(normalise_file_path("~/.config/nvim/disable-format-on-save.project.json"))
)

--- plugins

local plugins = {
    {
        "catppuccin/nvim",
        config = function()
            local mocha = require("catppuccin.palettes").get_palette("mocha")

            require("catppuccin").setup({
                color_overrides = {
                    mocha = { base = mocha.crust, mantle = mocha.crust },
                },
                custom_highlights = function(colors)
                    return {
                        ["@keyword.export"] = {
                            fg = colors.mauve,
                        },
                        ["@keyword.operator"] = {
                            fg = colors.mauve,
                        },
                        ["@lsp.type.operator.toml"] = {
                            fg = colors.overlay2,
                        },
                        ["Pmenu"] = {
                            bg = mocha.mantle,
                        },
                        ["StatusLine"] = {
                            bg = mocha.mantle,
                        },
                        ["StatusLineNC"] = {
                            bg = mocha.mantle,
                        },
                        ["WinSeparator"] = {
                            fg = mocha.mantle,
                        },
                    }
                end,
                flavour = "mocha",
                integrations = {
                    mini = {
                        enabled = true,
                    },
                },
                no_bold = true,
                no_italic = true,
                show_end_of_buffer = false,
            })

            vim.cmd.colorscheme("catppuccin")
        end,
        name = "catppuccin",
        priority = 1000,
        version = "1.10.0",
    },
    {
        "Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        enabled = false,
        opts = {
            bar = {
                padding = {
                    left = 6,
                },
            },
            win_configs = {
                border = vim.g.neovide and "single" or "double",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "╎",
                },
                scope = {
                    enabled = false,
                },
            })
        end,
        event = "BufRead",
        main = "ibl",
    },
    {
        "echasnovski/mini.ai",
        config = function() require("mini.ai").setup() end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.basics",
        config = function()
            require("mini.basics").setup({
                autocommands = {
                    relnum_in_visual_mode = true,
                },
                mappings = {
                    windows = false,
                },
                options = {
                    win_borders = vim.g.neovide and "single" or "double",
                },
            })
        end,
    },
    {
        "echasnovski/mini.bracketed",
        config = function()
            require("mini.bracketed").setup({
                diagnostic = { options = { severity = vim.diagnostic.severity.ERROR } },
            })
        end,
    },
    {
        "echasnovski/mini.bufremove",
        config = function()
            require("mini.bufremove").setup()

            vim.keymap.set("n", "<C-x>", require("mini.bufremove").delete, {
                desc = "Remove buffer",
                silent = true,
            })
        end,
    },
    {
        "echasnovski/mini.clue",
        config = function()
            local clue = require("mini.clue")

            clue.setup({
                clues = {
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.windows(),
                    clue.gen_clues.z(),

                    {
                        desc = "Telescope",
                        keys = "<Leader>f",
                        mode = "n",
                    },
                    {
                        desc = "Git",
                        keys = "<Leader>g",
                        mode = "n",
                    },
                    {
                        desc = "LSP",
                        keys = "<Leader>l",
                        mode = "n",
                    },
                    {
                        desc = "Mini map",
                        keys = "<Leader>m",
                        mode = "n",
                    },
                    {
                        desc = "Mini visits",
                        keys = "<Leader>a",
                        mode = "n",
                    },
                },
                triggers = {
                    { keys = "<C-w>", mode = "n" },
                    { keys = "<C-x>", mode = "i" },
                    { keys = "<Leader>", mode = "n" },
                    { keys = "<Leader>", mode = "x" },
                    { keys = "[", mode = "n" },
                    { keys = "[", mode = "x" },
                    { keys = "]", mode = "n" },
                    { keys = "]", mode = "x" },
                    { keys = "g", mode = "n" },
                    { keys = "g", mode = "x" },
                    { keys = "z", mode = "n" },
                    { keys = "z", mode = "x" },
                },
                window = {
                    delay = 1000,
                },
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.completion",
        config = function()
            require("mini.completion").setup({
                delay = { completion = 50, info = 50, signature = 50 },
                lsp_completion = {
                    process_items = function(...)
                        local items = require("mini.fuzzy").process_lsp_items(...)

                        for _, item in ipairs(items) do
                            if item.detail == "Emmet Abbreviation" then
                                item.kind = 15
                                item.labelDetails = nil
                            else
                                item.labelDetails = { detail = "C" }
                            end
                        end

                        return items
                    end,
                },
                window = { info = { border = "double" }, signature = { border = "double" } },
            })
        end,
        dependencies = {
            "echasnovski/mini.fuzzy",
        },
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.cursorword",
        config = function()
            local colors = require("catppuccin.palettes").get_palette("mocha")

            require("mini.cursorword").setup({ delay = 1000 })

            vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1, fg = colors.peach })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = colors.surface1, fg = colors.peach })
        end,
        dependencies = {
            "catppuccin/nvim",
        },
        event = "BufRead",
    },
    {
        "echasnovski/mini.diff",
        config = function()
            require("mini.diff").setup({
                options = {
                    wrap_goto = true,
                },
                view = {
                    priority = 0,
                    signs = { add = "+", change = "~", delete = "-" },
                    style = "number",
                },
            })

            vim.keymap.set("n", "<leader>gd", require("mini.diff").toggle_overlay, {
                desc = "Show diff",
                silent = true,
            })
        end,
    },
    {
        "echasnovski/mini.files",
        config = function()
            require("mini.files").setup({
                content = {
                    filter = function(entry) return entry.name ~= ".DS_Store" end,
                },
                windows = {
                    width_focus = 50,
                    width_nofocus = 25,
                },
            })

            vim.keymap.set("n", "_", require("mini.files").open, {
                desc = "Open mini.files",
                silent = true,
            })
            vim.keymap.set("n", "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, {
                desc = "Open mini.files (cwd)",
                silent = true,
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.fuzzy",
        config = function() require("mini.fuzzy").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.hipatterns",
        config = function()
            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.icons",
        config = function()
            require("mini.icons").setup()

            require("mini.icons").mock_nvim_web_devicons()
            require("mini.icons").tweak_lsp_kind()
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.indentscope",
        config = function()
            require("mini.indentscope").setup({
                draw = {
                    delay = 10,
                    animation = function() return 10 end,
                },
            })
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.jump2d",
        config = function()
            require("mini.jump2d").setup({
                mappings = {
                    start_jumping = "<leader>j",
                },
                view = {
                    dim = true,
                },
            })
        end,
        event = "BufRead",
    },
    {
        "echasnovski/mini.map",
        config = function()
            local MiniMap = require("mini.map")

            MiniMap.setup({
                integrations = {
                    MiniMap.gen_integration.builtin_search(),
                    MiniMap.gen_integration.diagnostic(),
                    MiniMap.gen_integration.diff(),
                },
                symbols = {
                    encode = MiniMap.gen_encode_symbols.dot("3x2"),
                    scroll_line = "▶",
                    scroll_view = "┃",
                },
                window = {
                    show_integration_count = false,
                    winblend = 75,
                },
            })

            vim.keymap.set("n", "<leader>mc", MiniMap.close, {
                desc = "Close",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mf", MiniMap.toggle_focus, {
                desc = "Toggle focus",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mo", MiniMap.open, {
                desc = "Open",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mr", MiniMap.refresh, {
                desc = "Refresh",
                silent = true,
            })
            vim.keymap.set("n", "<leader>ms", MiniMap.toggle_side, {
                desc = "Toggle side",
                silent = true,
            })
            vim.keymap.set("n", "<leader>mt", MiniMap.toggle, {
                desc = "Toggle",
                silent = true,
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.misc",
        config = function()
            require("mini.misc").setup()

            vim.api.nvim_create_user_command("ToggleZoom", function()
                local screen_width = vim.opt.columns:get()
                local window_width = 120

                local center = (screen_width - window_width) / 2

                local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":." .. vim.fn.getcwd())

                require("mini.misc").zoom(0, { col = center, title = file_name, width = window_width })
            end, { desc = "Toggle zoom" })
        end,
    },
    {
        "echasnovski/mini.move",
        config = function()
            require("mini.move").setup({
                mappings = {
                    -- stylua: ignore start
                    left        = "<S-left>",
                    right       = "<S-right>",
                    down        = "<S-down>",
                    up          = "<S-up>",
                    line_left   = "<S-left>",
                    line_right  = "<S-right>",
                    line_down   = "<S-down>",
                    line_up     = "<S-up>",
                    -- stylua: ignore end
                },
            })
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.notify",
        config = function()
            require("mini.notify").setup({
                content = {
                    format = function(notification)
                        local time = vim.fn.strftime("%H:%M:%S", math.floor(notification.ts_update))

                        return string.format("%s -> %s", time, notification.msg)
                    end,
                },
                lsp_progress = {
                    enable = false,
                },
                window = {
                    config = {
                        border = "double",
                    },
                },
            })

            vim.notify = require("mini.notify").make_notify()
        end,
    },
    {
        "echasnovski/mini.operators",
        config = function() require("mini.operators").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.pairs",
        config = function() require("mini.pairs").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.snippets",
        config = function()
            require("mini.snippets").setup({
                snippets = {
                    require("mini.snippets").gen_loader.from_lang(),
                },
            })
        end,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        enabled = false,
    },
    {
        "echasnovski/mini.splitjoin",
        config = function() require("mini.splitjoin").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.statusline",
        config = function()
            local MiniStatusLine = require("mini.statusline")

            MiniStatusLine.setup({
                content = {
                    active = function()
                        local _, mode_hl = MiniStatusLine.section_mode({ trunc_width = 75 })

                        local head = vim.fn.FugitiveHead()

                        return MiniStatusLine.combine_groups({
                            {
                                hl = mode_hl,
                                strings = {
                                    "λ",
                                },
                            },
                            {
                                hl = "StatusLine",
                                strings = {
                                    vim.bo.buftype == "terminal" and "%t" or "%f%m",
                                    "%<",
                                    head ~= "" and string.format(" %s", head),
                                    "%<",
                                    MiniStatusLine.section_diff({ trunc_width = 75 }),
                                    "%<",
                                    MiniStatusLine.section_diagnostics({ trunc_width = 75 }),
                                    "%=",
                                    "%l:%v",
                                },
                            },
                        })
                    end,
                },
                set_vim_settings = false,
            })
        end,
    },
    {
        "echasnovski/mini.surround",
        config = function() require("mini.surround").setup() end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.tabline",
        config = function() require("mini.tabline").setup() end,
    },
    {
        "echasnovski/mini.trailspace",
        config = function() require("mini.trailspace").setup() end,
    },
    {
        "echasnovski/mini.visits",
        config = function()
            local visits = require("mini.visits")

            visits.setup()

            vim.keymap.set("n", "<leader>as", visits.select_path, {
                desc = "Select path",
                silent = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                float = {
                    border = vim.g.neovide and "single" or "double",
                    show_header = false,
                },
                severity_sort = true,
                underline = true,
                virtual_text = false,
            })

            local capabilities = require("mini.completion").get_lsp_capabilities()

            capabilities.textDocument.completion.completionItem.snippetSupport = true

            vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach })

            local prettier_executable = executable_path({
                { priority = 0, path = string.format("%s/%s", "/opt/homebrew/bin", "prettier") },
                --- @diagnostic disable-next-line: undefined-field
                { priority = 1, path = string.format("%s/%s", vim.loop.cwd(), "node_modules/.bin/prettier") },
            })
            local prettier_config = {
                formatCommand = string.format("%s --stdin-filepath ${INPUT}", prettier_executable),
                formatStdin = true,
            }

            local lua_config = {
                formatCommand = "stylua --color Never -",
                formatStdin = true,
            }

            local languages = {
                css = {
                    prettier_config,
                },
                html = {
                    prettier_config,
                },
                javascript = {
                    prettier_config,
                },
                javascriptreact = {
                    prettier_config,
                },
                json = {
                    prettier_config,
                },
                jsonc = {
                    prettier_config,
                },
                lua = {
                    lua_config,
                },
                markdown = {
                    prettier_config,
                },
                sass = {
                    prettier_config,
                },
                scss = {
                    prettier_config,
                },
                typescript = {
                    prettier_config,
                },
                typescriptreact = {
                    prettier_config,
                },
                yaml = {
                    prettier_config,
                },
            }

            vim.lsp.config("efm", {
                capabilities = capabilities,
                filetypes = vim.tbl_keys(languages),
                init_options = { documentFormatting = true },
                on_attach = function(_, buffer)
                    vim.api.nvim_buf_create_user_command(buffer, "LspFormat", function() vim.lsp.buf.format() end, {
                        desc = "EFM - Format",
                    })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function(event)
                            for _, directory in pairs(disable_format_on_save) do
                                if is_inside_of_directory(event.match, directory) then return end
                            end

                            vim.lsp.buf.format()
                        end,
                        desc = "Format",
                        group = vim.api.nvim_create_augroup("format/efm", { clear = true }),
                    })
                end,
                settings = {
                    languages = languages,
                    rootMarkers = { ".git", "package.json" },
                },
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        format = {
                            enable = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })

            vim.lsp.config("vtsls", {
                capabilities = capabilities,
                on_attach = function(client, buffer)
                    on_attach(client, buffer)

                    local function action(name)
                        vim.lsp.buf.code_action({ apply = true, context = { diagnostics = {}, only = { name } } })
                    end

                    vim.api.nvim_buf_create_user_command(
                        buffer,
                        "LspAddMissingImports",
                        function() action("source.addMissingImports.ts") end,
                        {
                            desc = "[JS/TS] Add missing imports",
                        }
                    )
                    vim.api.nvim_buf_create_user_command(
                        buffer,
                        "LspOrganiseImports",
                        function() action("source.organizeImports") end,
                        {
                            desc = "[JS/TS] Organise imports",
                        }
                    )
                end,
                settings = {
                    vtsls = {
                        experimental = {
                            completion = {
                                enableServerSideFuzzyMatch = true,
                                entriesLimit = 1000,
                            },
                        },
                    },
                    javascript = {
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true,
                            },
                            functionLikeReturnTypes = {
                                enabled = true,
                            },
                            parameterNames = {
                                enabled = "literals",
                            },
                            parameterTypes = {
                                enabled = true,
                            },
                            propertyDeclarationTypes = {
                                enabled = true,
                            },
                            variableTypes = {
                                enabled = true,
                            },
                        },
                    },
                    typescript = {
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true,
                            },
                            functionLikeReturnTypes = {
                                enabled = true,
                            },
                            parameterNames = {
                                enabled = "literals",
                            },
                            parameterTypes = {
                                enabled = true,
                            },
                            propertyDeclarationTypes = {
                                enabled = true,
                            },
                            variableTypes = {
                                enabled = true,
                            },
                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })

            vim.lsp.enable({
                "bashls",
                "cssls",
                "cssmodules_ls",
                "efm",
                "emmet_language_server",
                "eslint",
                "gh_actions_ls",
                "html",
                "jsonls",
                "lua_ls",
                "tailwindcss",
                "tombi",
                "vtsls",
                "yamlls",
            })
        end,
        dependencies = {
            "mini.completion",
        },
        event = "BufReadPre",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            --- @diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                context_commentstring = {
                    enable = true,
                },
                ensure_installed = {
                    "bash",
                    "comment",
                    "css",
                    "dockerfile",
                    "fish",
                    "graphql",
                    "groovy",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jsonc",
                    "kdl",
                    "lua",
                    "markdown",
                    "prisma",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "vimdoc",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_file_size = 100 * 1024 -- 100 KB

                        --- @diagnostic disable-next-line: undefined-field
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                        return ok and stats and stats.size > max_file_size
                    end,
                },
                incremental_selection = {
                    enable = false,
                },
                indent = {
                    enable = true,
                },
            })

            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end,
        event = "BufRead",
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope")

            vim.keymap.set("n", "<leader>fa", picker("resume"), {
                desc = "Resume",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fb", picker("buffers"), {
                desc = "Buffers",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fc", picker("command_history"), {
                desc = "Command history",
                silent = true,
            })
            vim.keymap.set("n", "<leader>ff", picker("find_files"), {
                desc = "Find files",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fg", picker("live_grep"), {
                desc = "Live grep",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fh", picker("help_tags"), {
                desc = "Help tags",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fj", picker("jumplist"), {
                desc = "JumpList",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fm", picker("marks"), {
                desc = "Marks",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fq", picker("quickfix"), {
                desc = "QuickFix list",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fr", picker("grep_string"), {
                desc = "Grep string",
                silent = true,
            })
            vim.keymap.set("n", "<leader>fs", picker("search_history"), {
                desc = "Search history",
                silent = true,
            })
            vim.keymap.set("n", "<leader>ft", picker("treesitter"), {
                desc = "Treesitter",
                silent = true,
            })

            -- Git
            vim.keymap.set("n", "<leader>gc", picker("git_commits"), {
                desc = "Commits",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gr", picker("git_branches"), {
                desc = "Branches",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gs", picker("git_status"), {
                desc = "Status",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gt", picker("git_stash"), {
                desc = "Stash",
                silent = true,
            })

            local mappings = {
                ["<c-h>"] = require("telescope.actions").file_split,
                ["<c-x>"] = false,
                ["<m-q>"] = function(bufnr)
                    require("telescope.actions").smart_send_to_qflist(bufnr)
                    require("telescope.builtin").quickfix()
                end,
            }

            telescope.setup({
                defaults = require("telescope.themes").get_ivy({
                    initial_mode = "insert",
                    mappings = { i = mappings, n = mappings },
                }),
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_cursor({
                        initial_mode = "insert",
                    }),
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-x>"] = "delete_buffer",
                            },
                            n = {
                                ["<c-x>"] = "delete_buffer",
                            },
                        },
                    },
                    find_files = {
                        hidden = true,
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    },
    {
        "tpope/vim-dadbod",
        config = function()
            vim.api.nvim_create_autocmd("BufReadPost", {
                callback = function() vim.b.minitrailspace_disable = true end,
                desc = "Disable mini.trailspace for vim-dadbod output window",
                group = group("DadBodDisableTrailSpace"),
                pattern = "*.dbout",
            })
        end,
        enabled = false,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>ga", "<cmd>Git add %<cr>", {
                desc = "Add (current file)",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", {
                desc = "Blame",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>", {
                desc = "Open fugitive pane",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gn", "<cmd>Git commit --no-verify<cr>", {
                desc = "Commit (--no-verify)",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", {
                desc = "Push",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gf", "<cmd>diffget //2<cr>", {
                desc = "Accept from left",
                silent = true,
            })
            vim.keymap.set("n", "<leader>gj", "<cmd>diffget //3<cr>", {
                desc = "Accept from right",
                silent = true,
            })
        end,
    },
}

require("lazy").setup(plugins, { change_detection = { enabled = false } })
