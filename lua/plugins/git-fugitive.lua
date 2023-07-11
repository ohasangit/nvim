return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gw',  '<cmd>Gwrite<cr>',                desc = 'Git write' },
    { '<leader>gc',  '<cmd>G commit<cr>',              desc = 'Git commit' },
    { '<leader>gp',  '<cmd>G push<cr>',                desc = 'Git push' },
    { '<leader>gpu', '<cmd>G push -u origin HEAD<cr>', desc = 'Git push and track' },
    { '<leader>gpf', '<cmd>G push --force<cr>',        desc = 'Git force push' },
    { '<leader>gpp', '<cmd>G pull<cr>',                desc = 'Git pull' },
  }
}
