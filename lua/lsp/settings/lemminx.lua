return {
    root_dir = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return vim.fs.root(fname, { 'pom.xml', 'build.gradle', '.git' })
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
