return function(...)
    local success, result = pcall(...)

    return not success and { success = false, error = result } or { success = true, data = result }
end
