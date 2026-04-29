return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').setup({
                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                -- List of parsers that should always be installed
                ensure_installed = {
                    'typescript',
                    'javascript',
                    'tsx',
                    'lua',
                    'vim',
                    'vimdoc',
                    'markdown',
                    'markdown_inline',
                    'bash',
                    'json',
                    'yaml',
                    'html',
                    'css',
                    'rust',
                    'python',
                },

                -- Note: We enable highlight here so that nvim-treesitter 
                -- can manage the integration, but we prioritize native 
                -- 0.12 features where possible.
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,
            max_lines = 3,
            trim_scope = 'outer',
        },
    },
}
