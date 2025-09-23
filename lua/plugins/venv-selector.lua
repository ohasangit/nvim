return {
  'linux-cultist/venv-selector.nvim',
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select Virtualenv' },
    { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = 'Select Cached Virtualenv' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'mfussenegger/nvim-dap-python',
  },
  opts = {
    options = {
      notify_user_on_activate = true,
      enable_cached_venvs = true,
      cached_venv_automatic_activation = true,
    },
  },
}
