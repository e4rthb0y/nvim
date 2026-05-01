-- Buffer navigation
vim.keymap.set('n', 'bn', ':bn<cr>') -- next buffer
vim.keymap.set('n', 'bp', ':bp<cr>') -- prev buffer
vim.keymap.set('n', 'bd', ':bd<cr>') -- remove buffer

-- Delete a word backwards (idiomatic)
vim.keymap.set('n', 'dw', 'diw') -- Delete inside word

-- Select all text in buffer
vim.keymap.set('n', '<C-a>', 'ggVG')

-- New tab
vim.keymap.set('n', 'te', ':tabedit<Return>')

-- Split window
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Swipe line up/down (improved for visual/normal)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

-------------------
-- Terminal Mappings

-- Normal mode swichers
vim.keymap.set('t', '<A-[>', '<Esc>')
vim.keymap.set('t', '<Esc>', '<c-\\><c-n>')

-- Navigation between terminal windows
vim.keymap.set('t', '<A-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<A-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<A-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<A-l>', '<c-\\><c-n><c-w>l')

-- Explicitly pass modified Enter keys to terminal
vim.keymap.set('t', '<C-CR>', '<C-CR>')
vim.keymap.set('t', '<S-CR>', '<S-CR>')
vim.keymap.set('t', '<C-S-CR>', '<C-S-CR>')
