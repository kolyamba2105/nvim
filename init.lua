require("core")

local function setup_luarocks()
    -- stylua: ignore start
    local path          = "/opt/homebrew/Cellar/luarocks/3.9.2/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/mykola/.luarocks/share/lua/5.4/?.lua;/Users/mykola/.luarocks/share/lua/5.4/?/init.lua"
    local cpath         = "/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/mykola/.luarocks/lib/lua/5.4/?.so"

    vim.o.runtimepath   = string.format("%s,%s", vim.o.runtimepath, path)

    package.path        = string.format("%s;%s", package.path, path)
    package.cpath       = string.format("%s;%s", package.cpath, cpath)
    -- stylua: ignore end
end

setup_luarocks()

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

require("lazy").setup("plugins", { change_detection = { enabled = false } })
