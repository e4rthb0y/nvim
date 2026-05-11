return {
    root_dir = function(fname)
        if fname:match('%.template$') then
            return nil
        end
        return require('lspconfig.util').root_pattern('.git', 'package.json')(
            fname
        )
    end,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
