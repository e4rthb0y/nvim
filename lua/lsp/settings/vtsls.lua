return {
    root_dir = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local deno_root = vim.fs.root(fname, { 'deno.json', 'deno.jsonc' })
        local node_root =
            vim.fs.root(fname, { 'package.json', 'tsconfig.json' })

        if deno_root and node_root then
            return (#node_root >= #deno_root) and node_root or nil
        end
        return node_root
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
