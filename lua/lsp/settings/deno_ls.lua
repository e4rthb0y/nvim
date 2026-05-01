local util = require('lspconfig.util')

return {
    root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
    init_options = {
        enable = true,
        lint = true,
        unstable = true,
    },
}
