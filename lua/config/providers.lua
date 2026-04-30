local function has(cmd)
    return vim.fn.executable(cmd) == 1
end

-- Python
if has('python3') then
    vim.g.python3_host_prog = vim.fn.exepath('python3')
else
    vim.g.loaded_python3_provider = 0
end

-- Ruby
if not has('ruby') then
    vim.g.loaded_ruby_provider = 0
end

-- Node
if not has('node') then
    vim.g.loaded_node_provider = 0
end

-- Perl
if not has('perl') then
    vim.g.loaded_perl_provider = 0
end

-- System tools
vim.g.has_rg = has('rg')
vim.g.has_fd = has('fd')
vim.g.has_fzf = has('fzf')
