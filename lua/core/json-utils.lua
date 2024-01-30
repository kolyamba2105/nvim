local json = require("json")

local M = {}

function M.decode_json_file(path)
    local file = io.open(path, "r")

    if not file then error(string.format("%s: %s", "Unable to open file", path)) end

    local data = file:read("*a")

    file:close()

    local result = json.decode(data)

    if not result then error(string.format("%s: %s", "Unable to decode file content", path)) end

    return result
end

return M
