local util = require('lspconfig.util')

return {
    root_dir = function(fname)
        local deno_root = util.root_pattern('deno.json', 'deno.jsonc')(fname)
        if deno_root then
            return nil
        end
        return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
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
