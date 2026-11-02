-- Parsers to keep installed. Besides buffer highlighting, these also drive the
-- highlighting of fenced code blocks inside LSP hover/signature floats, which
-- render as treesitter markdown with language injections.
local parsers = {
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
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- The `main` branch dropped `ensure_installed`/`highlight`/`indent`
            -- options from setup(); installation and activation are explicit.
            require('nvim-treesitter').install(parsers)

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup(
                    'treesitter_start',
                    { clear = true }
                ),
                callback = function(event)
                    -- Silently skip filetypes without an installed parser
                    if not pcall(vim.treesitter.start, event.buf) then
                        return
                    end
                    vim.bo[event.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
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
