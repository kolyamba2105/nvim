vim.api.nvim_create_user_command("CopyBufferPath", function()
    local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":." .. vim.fn.getcwd())

    vim.fn.setreg("+", path)
    print("Buffer path '" .. path .. "' copied to clipboard")
end, {})
