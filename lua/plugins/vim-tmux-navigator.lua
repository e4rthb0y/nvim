return {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    init = function()
        -- Disable default mappings to prevent conflicts in Terminal mode
        -- (specifically avoiding <C-j> hijacking modified Enter keys)
        vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
        { '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
        { '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
        { '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
        { '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
        { '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>' },
    },
}
