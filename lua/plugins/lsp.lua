local function set_lspconfig()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local mason_registry = require('mason-registry')
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local servers = require('lsp.servers')
    local formatters = require('lsp.formatters')
    local linters = require('lsp.linters')

    local function lsp_server_handler(server_name)
        local has_custom_opts, server_opts =
            pcall(require, 'lsp.settings.' .. server_name)

        local opts = {
            capabilities = capabilities,
        }

        if has_custom_opts then
            opts = vim.tbl_deep_extend('force', opts, server_opts)
        end

        vim.lsp.config(server_name, opts)
        vim.lsp.enable(server_name)
    end

    mason_lspconfig.setup({
        ensure_installed = servers.to_install(),
    })

    -- Install additional tools (formatters, etc)
    local tools = vim.list_extend(formatters.to_install(), linters.to_install())
    for _, tool in ipairs(tools) do
        local p = mason_registry.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end

    for _, name in ipairs(servers.to_setup()) do
        lsp_server_handler(name)
    end
end
local function set_keymaps()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local map = function(mode, keys, func, desc)
                vim.keymap.set(
                    mode,
                    keys,
                    func,
                    { buffer = event.buf, desc = 'LSP: ' .. desc }
                )
            end

            map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
            map('n', 'K', vim.lsp.buf.hover, 'Hover')
            map(
                'n',
                '<leader>vd',
                vim.diagnostic.setloclist,
                'Show Diagnostics'
            )
            map('n', '[d', function()
                vim.diagnostic.jump({ count = 1 })
            end, 'Next Diagnostic')
            map('n', ']d', function()
                vim.diagnostic.jump({ count = -1 })
            end, 'Previous Diagnostic')
            map(
                'n',
                '<leader>vws',
                vim.lsp.buf.workspace_symbol,
                'Workspace Symbol'
            )
        end,
    })
end

local lazydev = { 'folke/lazydev.nvim' }
lazydev.ft = 'lua'
lazydev.opts = {
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks', 'snacks' } },
    },
}

local mason = { 'williamboman/mason.nvim' }
mason.config = function()
    require('mason').setup({
        registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
        },
    })
end

local lspconfig = { 'neovim/nvim-lspconfig' }

lspconfig.dependencies = {
    -- Infrastructure
    lazydev,
    mason,
    'williamboman/mason-lspconfig.nvim',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind.nvim',

    -- servers
    'b0o/schemastore.nvim',

    -- Langugage Plugins
    'mfussenegger/nvim-jdtls', -- Java engine
    'seblyng/roslyn.nvim', -- C# engine
}

lspconfig.config = function()
    vim.lsp.log.set_level('debug')
    set_lspconfig()
    set_keymaps()

    require('lsp.completion').setup()
    require('lsp.ui').setup()
end

return lspconfig
