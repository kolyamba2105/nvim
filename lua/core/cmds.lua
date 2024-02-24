vim.api.nvim_create_user_command("CopyBufferPath", function()
    local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":." .. vim.fn.getcwd())

    vim.fn.setreg("+", file_name)
    print(string.format("Copied: %s", file_name))
end, { desc = "Copy current buffer path" })
