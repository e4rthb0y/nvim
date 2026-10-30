---@type vim.lsp.Config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { 'pom.xml', 'build.gradle', '.git' })

        if root then
            on_dir(root)
        end
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
