local function command(name, fn) return vim.api.nvim_create_user_command(name, fn, {}) end

local function get_file_name() return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":." .. vim.fn.getcwd()) end

local function get_test_name() return string.match(vim.api.nvim_get_current_line(), "[test|it]%(['\"]([^'\"]*)['\"]") end

command("CopyBufferPath", function()
    local file_name = get_file_name()

    vim.fn.setreg("+", file_name)
    print(string.format("Copied: %s", file_name))
end)

command("CopyTestCommand", function()
    local cmd = string.format("yarn jest %s", get_file_name())

    vim.fn.setreg("+", cmd)
    print(string.format("Copied: %s", cmd))
end)

command("CopyTestCaseCommand", function()
    local file_name = get_file_name()
    local test_name = get_test_name()

    if test_name == nil then
        print("Unable to resolve test name!")
    else
        local cmd = string.format('yarn jest %s -t "%s"', file_name, test_name)

        vim.fn.setreg("+", cmd)
        print(string.format("Copied: %s", cmd))
    end
end)

return command
