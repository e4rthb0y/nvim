return {
    -- @param bufnr integer
    -- @param callback function
    root_dir = function(bufnr, callback)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root =
            vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', '.git' })
        callback(root)
    end,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
