return {
    ---@type LSPRootHandler
    root_dir = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return vim.fs.root(fname, { 'deno.json', 'deno.jsonc' })
    end,
    single_file_support = false,
    init_options = {
        enable = true,
        lint = true,
        unstable = true,
    },
}
