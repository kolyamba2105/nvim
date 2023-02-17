local M = {}

function M.get_picker(picker)
  return function(options) return require("telescope.builtin")[picker](options) end
end

function M.get_picker_insert(picker)
  return function() M.get_picker(picker)({ initial_mode = "insert" }) end
end

return M
