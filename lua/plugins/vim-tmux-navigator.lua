return {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    init = function()
        -- Disable default mappings to prevent conflicts in Terminal mode
        -- (specifically avoiding <C-j> hijacking modified Enter keys)
        vim.g.tmux_navigator_no_mappings = 1
    end,
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
    },
    keys = {
        { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
        { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
        { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
        { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
        { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
}
