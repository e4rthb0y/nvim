return {
    -- @param bufnr integer
    -- @param callback function
    root_dir = function(bufnr, callback)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { 'pom.xml', 'build.gradle', '.git' })
        callback(root)
    end,
    settings = {
        xml = {
            format = {
                enabled = true,
                splitAttributes = true,
            },
        },
    },
}
