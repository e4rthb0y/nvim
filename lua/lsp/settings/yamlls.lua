return {
    ---@type LSPRootHandler
    root_dir = function(bufnr, callback)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { '.git' })
        callback(root)
    end,
    on_attach = function(client)
        -- Disable yamlls formatting to let Conform handle it exclusively
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    on_new_config = function(new_config)
        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            new_config.settings.yaml.schemas or {},
            require('schemastore').yaml.schemas()
        )
    end,
    settings = {
        yaml = {
            schemaStore = { enable = false, url = '' },
        },
    },
}
