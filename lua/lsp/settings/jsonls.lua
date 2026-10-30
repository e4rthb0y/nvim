---@type vim.lsp.Config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if fname:match('%.template$') then
            return
        end

        local root = vim.fs.root(fname, { '.git' }) or vim.fs.dirname(fname)

        if root then
            on_dir(root)
        end
    end,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
