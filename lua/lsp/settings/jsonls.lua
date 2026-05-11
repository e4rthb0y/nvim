return {
    root_dir = function(fname)
        if fname:match('%.template$') then
            return nil
        end
        local deno_root = vim.fs.root(fname, { 'deno.json', 'deno.jsonc' })
        local node_root = vim.fs.root(fname, { 'package.json' })

        if deno_root and node_root then
            return (#node_root >= #deno_root) and node_root or nil
        end
        return node_root
    end,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
