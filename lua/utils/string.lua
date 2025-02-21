local M = {}

--- @param string string
--- @return string
M.capitalize = function(string) return string:sub(1, 1):upper() .. string:sub(2):lower() end

return M
