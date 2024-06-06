local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<leader>od', '<cmd>Octo pr diff<cr>', opts)
keymap('n', '<leader>oca', '<cmd>Octo pr changes<cr>', opts)
keymap('n', '<leader>och', '<cmd>Octo pr checks<cr>', opts)
keymap('n', '<leader>r', '<cmd>Octo pr reload<cr>', opts)
keymap('n', '<leader>c', '<cmd>Octo pr comment add<cr>', opts)
keymap('n', '<leader>th', '<cmd>Octo reaction thumbs_up<cr>', opts)
keymap('n', '<C-m><C-m>', '<cmd>Octo pr merge squash<cr>', opts)
