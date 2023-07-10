return {
  'ruifm/gitlinker.nvim',
  keys = {
    { '<leader>gy', mode = 'n', desc = 'Browser navigate to file repo url' },
    { '<leader>gy', mode = 'v', desc = 'Copy selected range url to clipboard' }
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set(
      'n',
      '<leader>gy',
      '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      { noremap = true, silent = true, desc = 'Browser navigate to file repo url' }
    )
    vim.keymap.set(
      'v',
      '<leader>gy',
      '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>',
      { noremap = true, desc = 'Copy selected range url to clipboard' }
    )
  end,
}
