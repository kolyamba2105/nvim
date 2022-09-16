local M = {}

M.is_linux = function()
  return vim.loop.os_uname().sysname == "Linux"
end

M.keys = function(t)
  local result = {}

  for key in pairs(t) do
    table.insert(result, key)
  end

  return result
end

return M
