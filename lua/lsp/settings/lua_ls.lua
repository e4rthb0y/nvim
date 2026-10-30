local LUA_MARKERS = { '.luarc.json', '.luarc.jsonc', '.git' }

---@type vim.lsp.Config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, LUA_MARKERS)

        if root then
            on_dir(root)
        end
    end,
    settings = {
        Lua = {
            diagnostics = {
                neededFileStatus = { ['undefined-global'] = 'None' },
            },
            typeChecking = {
                level = 'Information',
                strictLevel = 'Essential',
            },
        },
    },
}
