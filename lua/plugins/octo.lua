return {
  'pwntester/octo.nvim',
  keys = {
    { '<leader>op',  '<cmd>Octo pr create<cr>', desc = 'Github Create PR' },
    { '<leader>opr', '<cmd>Octo pr<cr>',        desc = 'Github PR for current branch' },
    { '<leader>os',  '<cmd>Octo search<cr>',    desc = 'Github Search' },
    { '<leader>ol',  '<cmd>Octo pr list<cr>',   desc = 'Github List PRs' },
    { '<leader>om',  '<cmd>Octo pr merge squash<cr>',     desc = 'Github Merge PR' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    suppress_missing_scope = {
      projects_v2 = true,
    }
  },
  config = function(_, opts)
    require('octo').setup(opts)
  end,
}
