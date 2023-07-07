return {
  'ruifm/gitlinker.nvim',
  keys = { '<leader>gy', '<leader>gY', { '<leader>gy', mode = 'v' } },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set(
      'n',
      '<leader>gY',
      '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      { noremap = true, silent = true }
    )
  end,
}
