local command = require("core.cmds")

local function center_split()
    -- Fast return if there is more than 1 split
    if vim.tbl_count(vim.api.nvim_list_wins()) > 1 then return end

    -- Create an empty vertical split
    vim.cmd("vsplit")
    vim.cmd("enew")

    -- Create another vertical split
    vim.cmd("vsplit")

    -- Focus center split
    vim.cmd("wincmd h")

    -- Move center split to the very right
    vim.cmd("wincmd H")

    -- Resize left-most split to be 80% width
    vim.cmd("vertical resize 80")

    -- Focus right-most split
    vim.cmd("wincmd l")
    vim.cmd("wincmd l")

    -- Resize right-most split to be 80% width
    vim.cmd("vertical resize 80")

    -- Focus center split
    vim.cmd("wincmd h")
end

command("CenterSplit", center_split)

vim.keymap.set("n", "<leader>c", center_split, {
    desc = "Center split",
})
