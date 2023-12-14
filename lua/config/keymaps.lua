local map = vim.keymap.set

-- Normal --
-- Better window navigation
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Move to window left' })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Move to window down' })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Move to window up' })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Move to window right' })

-- Resize with arrows
map('n', '<C-Up>', '<cmd>resize +2<CR>', { noremap = true, silent = true, desc = 'Resize window upwards' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { noremap = true, silent = true, desc = 'Resize window downwards' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { noremap = true, silent = true, desc = 'Resize window to the left' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>',
  { noremap = true, silent = true, desc = 'Resize window to the right' })

-- Quick Saving --
map('n', '<leader>w', ':w<cr>', { noremap = true, silent = true, desc = 'Write buffer to file' })

-- Quick Window Close/Exit --
map('n', '<leader>q', ':q<cr>', { noremap = true, silent = true, desc = 'Quit' })

-- Quick Buffer Close --
map('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = 'Close Buffer' })

-- Quick Commands --
map('n', '<leader>;', ':', { noremap = true, desc = 'Enter Command Mode' })

-- Remove Highlighting
map('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true, desc = 'Clear search highlighting' })

-- Visual --
-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- Move text up and down
map('v', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move selection up' })
map('v', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move selection down' })

-- Replace with buffer
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Replace selection with register contents' })

-- Visual Block --
-- Move text up and down
map('x', '<A-k>', ':move \'<-2<CR>gv-gv', { noremap = true, silent = true, desc = 'Move selection up' })
map('x', '<A-j>', ':move \'>+1<CR>gv-gv', { noremap = true, silent = true, desc = 'Move selection down' })

-- Terminal --
-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true, desc = 'Move to window left' })
map('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true, desc = 'Move to window down' })
map('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true, desc = 'Move to window up' })
map('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true, desc = 'Move to window right' })

-- Lazy (Not sure of a better place)
map('n', '<leader>hj', '<cmd>Lazy<CR>', { noremap = true, silent = true, desc = 'Plugin (Lazy) Menu' })

-- Format file
map('n', '<leader>af', '<cmd>lua Lsp.select_formatter()<CR>',
  { noremap = true, silent = true, desc = 'Format file' })
