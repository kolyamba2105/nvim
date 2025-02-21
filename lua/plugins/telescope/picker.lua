--- @param name string
--- @param options? { [string]: unknown }
return function(name, options)
    return function()
        return require("telescope.builtin")[name](vim.tbl_extend("force", { initial_mode = "insert" }, options or {}))
    end
end
