local M = {}

local raw_linters = {
    'selene',
}

---Returns a plain list of linter names for Mason installation.
---@return string[]
function M.to_install()
    local list = {}
    for _, l in ipairs(raw_linters) do
        if type(l) == 'string' then
            table.insert(list, l)
        end
    end
    return list
end

return M
