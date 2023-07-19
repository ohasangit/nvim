return {
  'pwntester/octo.nvim',
  keys = {
    { '<leader>op', '<cmd>Octo pr create<cr>', desc = 'Github Create PR' },
    { '<leader>os', '<cmd>Octo search<cr>',    desc = 'Github Search' },
    { '<leader>ol', '<cmd>Octo pr list<cr>',   desc = 'Github List PRs' },
    { '<leader>om', '<cmd>Octo merge<cr>',     desc = 'Github Merge PR' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = true
}
