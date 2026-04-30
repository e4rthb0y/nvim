local M = {}

local function check_executable(cmd, advice)
    if vim.fn.executable(cmd) == 1 then
        vim.health.ok(cmd .. ' is installed')
    else
        vim.health.error(cmd .. ' is not installed', advice)
    end
end

function M.check()
    vim.health.start('System Dependencies')

    check_executable(
        'rg',
        "ripgrep is required for fuzzy searching in Telescope. Install it with 'brew install rg' or your package manager."
    )
    check_executable(
        'fd',
        "fd is required for fast file finding. Install it with 'brew install fd' or your package manager."
    )
    check_executable(
        'fzf',
        "fzf is recommended for fuzzy finding. Install it with 'brew install fzf' or your package manager."
    )

    vim.health.start('Runtime Dependencies')
    check_executable(
        'node',
        "Node.js is required for some LSPs (like ts_ls). Install it with 'brew install node' or use nvm."
    )
    check_executable(
        'python3',
        "Python 3 is required for some plugins. Install it with 'brew install python'."
    )
    check_executable(
        'ruby',
        "Ruby is required for some plugins. Install it with 'brew install ruby'."
    )

    vim.health.start('Development Tools')
    check_executable(
        'stylua',
        "Stylua is required for Lua formatting. Install it with 'brew install stylua'."
    )
    check_executable(
        'selene',
        "Selene is required for Lua linting. Install it with 'cargo install selene' or download the binary."
    )
end

return M
