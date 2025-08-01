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
map(
  'n',
  '<C-Left>',
  '<cmd>vertical resize -2<CR>',
  { noremap = true, silent = true, desc = 'Resize window to the left' }
)
map(
  'n',
  '<C-Right>',
  '<cmd>vertical resize +2<CR>',
  { noremap = true, silent = true, desc = 'Resize window to the right' }
)

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
map('x', '<A-k>', ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = 'Move selection up' })
map('x', '<A-j>', ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = 'Move selection down' })

-- Terminal --
map('t', '<C-Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit Terminal Mode' })
-- Resize with arrows
map('t', '<C-Up>', '<cmd>resize +2<CR>', { noremap = true, silent = true, desc = 'Resize window upwards' })
map('t', '<C-Down>', '<cmd>resize -2<CR>', { noremap = true, silent = true, desc = 'Resize window downwards' })

-- Keymap to call the function in terminal mode
vim.api.nvim_set_keymap(
  't',
  '<C-y>',
  '<C-\\><C-n>:lua require("utils.keymap-functions").yank_current_command()<CR>i',
  { noremap = true, silent = true }
)

-- Lazy (Not sure of a better place)
map('n', '<leader>hj', '<cmd>Lazy<CR>', { noremap = true, silent = true, desc = 'Plugin (Lazy) Menu' })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>af', '<cmd>lua require("conform").format()<CR>', opts)

-- Keymap for pasting in terminal mode
vim.api.nvim_set_keymap(
  't',
  '<C-V>',
  '<C-\\><C-n>"+gP<C-\\><C-n>i',
  { noremap = true, silent = true, desc = 'Terminal mode paste' }
)

-- LSP keymaps
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>li', '<cmd>LspInfo<CR>', opts)

-- Keymap to copy git branch name
map(
  'n',
  '<leader>gyy',
  '<cmd>lua require("utils.git").copy_branch_name()<CR>',
  { noremap = true, silent = true, desc = 'Copy git branch name' }
)
