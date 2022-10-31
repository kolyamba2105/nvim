local M = {}

M.keys = function(t)
  local result = {}

  for key in pairs(t) do
    table.insert(result, key)
  end

  return result
end

return M
