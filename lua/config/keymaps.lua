local map = vim.keymap.set

-- Normal --
-- Better window navigation
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = "Move to window left"})
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = "Move to window down"})
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = "Move to window up"})
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = "Move to window right"})

-- Resize with arrows
map('n', '<C-Up>', '<cmd>resize +2<CR>', { noremap = true, silent = true, desc = "Resize window upwards" })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { noremap = true, silent = true, desc = "Resize window downwards" })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { noremap = true, silent = true, desc = "Resize window to the left" })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { noremap = true, silent = true, desc = "Resize window to the right" })

-- Quick Saving --
map('n', '<leader>w', ':w<cr>', { noremap = true, silent = true, desc = "Write buffer to file" })

-- Quick Window Close/Exit --
map('n', '<leader>q', ':q<cr>', { noremap = true, silent = true, desc = "Quit" })

-- Quick Buffer Close --
map('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = "Close Buffer" })

-- Quick Commands --
map('n', '<leader>;', ':', { noremap = true, desc = "Enter Command Mode" })

-- Remove Highlighting
map('n', '<cr>', ':noh<cr>', { noremap = true, silent = true, desc = "Clear search highlighting" })

-- Visual --
-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- Move text up and down
map('v', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = "Move selection up" })
map('v', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = "Move selection down" })

-- Replace with buffer
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = "Replace selection with register contents" })

-- Visual Block --
-- Move text up and down
map('x', '<A-k>', ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "Move selection up" })
map('x', '<A-j>', ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "Move selection down" })

-- Terminal --
-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true, desc = "Move to window left" })
map('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true, desc = "Move to window down" })
map('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true, desc = "Move to window up" })
map('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true, desc = "Move to window right" })

-- Lazy (Not sure of a better place)
map('n', '<leader>hj', '<cmd>Lazy<CR>', { noremap = true, silent = true, desc = "Plugin (Lazy) Menu" })

--[[ Commenting plugin specific keybinds for now
-- Git --
keymap(
  'n',
  '<leader>gy',
  '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  opts
)

-- Browser --
keymap('n', '<leader>goo', ':OpenBrowserSmartSearch ', { noremap = true })
keymap('n', '<c-g>', '<Plug>(openbrowser-smart-search)', term_opts)
keymap('n', '<leader>b', '<cmd>Telescope bookmarks<cr>', term_opts)

-- Octo --
keymap('n', '<leader>op', '<cmd>Octo pr create<cr>', opts)
keymap('n', '<leader>os', '<cmd>Octo search<cr>', opts)
keymap('n', '<leader>ol', '<cmd>Octo pr list<cr>', opts)
keymap('n', '<leader>om', '<cmd>Octo pr merge squash<cr>', opts)

-- Terminal --
-- Keymap for neovim terminal command in a horizontal split with 30% height
keymap('n', '<leader>tt', '<cmd>24split | terminal<cr>', opts)

-- ChatGPT --
-- Keymap for Chatgpt command
keymap('n', '<leader>cc', '<cmd>ChatGPT<cr>', opts)
keymap('v', '<C-O>', '<cmd>ChatGPTRun optimize_code<cr>', opts)
keymap('v', '<C-T>', '<cmd>ChatGPTRun add_tests<cr>', opts)
keymap('v', '<C-D>', '<cmd>ChatGPTRun docstring<cr>', opts)
keymap('v', '<C-F>', '<cmd>ChatGPTRun fix_bugs<cr>', opts)
keymap('n', '<leader>ce', '<cmd>ChatGPTEditWithInstructions<cr>', opts)

-- Trouble --
keymap('n', '<leader>di', '<cmd>TroubleToggle<cr>', opts)
keymap('n', '<leader>dw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
keymap('n', '<leader>di', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
keymap('n', '<leader>dl', '<cmd>TroubleToggle loclist<cr>', opts)
keymap('n', '<leader>dq', '<cmd>TroubleToggle quickfix<cr>', opts)
keymap('n', '<leader>dg', '<cmd>TroubleToggle lsp_references<cr>', opts)

-- DAP --
keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<cr>', opts)
keymap('n', '<leader>dB', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint Condition: "))<cr>', opts)
keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<cr>', opts)
keymap('n', '<leader>ds', '<cmd>lua require"dap".step_into()<cr>', opts)
keymap('n', '<leader><leader>', '<cmd>lua require"dap".step_over()<cr>', opts)
keymap('n', '<leader>du', '<cmd>lua require"dap".step_out()<cr>', opts)
keymap('n', '<leader>dd', '<cmd>lua require"dapui".toggle()<cr>', opts)
keymap('n', '<leader>dt', '<cmd>lua require"dap-python".test_method()<cr>', opts)
keymap('n', '<leader>dR', '<cmd>lua require"dap".run_last()<cr>', opts)
keymap('n', '<leader>do', '<cmd>lua require"dap".run_to_cursor()<cr>', opts)
keymap('n', '<leader>df', '<cmd>lua require"dap".focus_frame()<cr>', opts)
keymap('n', '<leader>dr', '<cmd>lua require"dap".restart()<cr>', opts)

-- Neotest --
keymap('n', '<leader>tt', '<cmd>lua require"neotest".run.run()<cr>', opts)
keymap('n', '<leader>ta', '<cmd>lua require"neotest".run.run(vim.fn.expand("%"))<cr>', opts)
keymap('n', '<leader>ts', '<cmd>lua require"neotest".summary.toggle()<cr>', opts)
keymap('n', '<leader>tr', '<cmd>lua require"neotest".output.open({ enter = true })<cr>', opts)

--]]
