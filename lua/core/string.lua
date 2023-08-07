local M = {}

M.capitalize = function(string) return string:sub(1, 1):upper() .. string:sub(2) end

M.pad_right = function(string) return string .. " " end

return M
