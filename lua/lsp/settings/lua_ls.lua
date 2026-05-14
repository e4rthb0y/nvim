return {
    ---@type LSPRootHandler
    root_dir = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', '.git' })
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
