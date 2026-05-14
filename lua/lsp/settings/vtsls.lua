return {
    ---@type LSPRootHandler
    root_dir = function(bufnr, callback)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local deno_root = vim.fs.root(fname, { 'deno.json', 'deno.jsonc' })
        local node_root =
            vim.fs.root(fname, { 'package.json', 'tsconfig.json' })

        if deno_root and node_root then
            callback((#node_root >= #deno_root) and node_root or nil)
            return
        end
        callback(node_root)
    end,
    single_file_support = false,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayVariableTypeHints = true,
            },
        },
    },
}
