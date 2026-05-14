return {
    ---@type LSPRootHandler
    root_dir = function(bufnr, callback)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { 'deno.json', 'deno.jsonc' })
        callback(root)
    end,
    init_options = {
        enable = true,
        lint = true,
        unstable = true,
    },
}
