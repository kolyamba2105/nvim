local TU = {}

function TU.get_picker(picker)
    return function(options) return require("telescope.builtin")[picker](options) end
end

function TU.get_picker_insert(picker)
    return function(options)
        TU.get_picker(picker)(vim.tbl_extend("force", options or {}, { initial_mode = "insert" }))
    end
end

return TU
