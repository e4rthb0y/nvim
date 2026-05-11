local util = require('lspconfig.util')

return {
    root_dir = util.root_pattern(
        'package.json',
        'tsconfig.json',
        'jsconfig.json',
        '.git'
    ),
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
