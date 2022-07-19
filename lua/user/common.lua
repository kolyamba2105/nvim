local M = {}

M.is_linux = function()
  return vim.loop.os_uname().sysname == "Linux"
end

return M
