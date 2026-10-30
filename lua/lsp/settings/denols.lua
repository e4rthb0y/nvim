local workspace = require('../workspace.lua')

---@type vim.lsp.Config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = workspace.get_exclusive_ts_root(fname, 'denols')

        if root then
            on_dir(root)
        end
    end,
    single_file_support = false,
    init_options = {
        enable = true,
        lint = true,
        unstable = true,
    },
}
