require("core")

local repo = "https://github.com/folke/lazy.nvim.git"
local path = string.format("%s/lazy/lazy.nvim", vim.fn.stdpath("data"))

--- @diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(path) then
    vim.fn.system({ "git", "clone", "--branch=stable", "--filter=blob:none", repo, path })
end

vim.opt.rtp:prepend(path)

require("lazy").setup("plugins", { change_detection = { enabled = false } })
