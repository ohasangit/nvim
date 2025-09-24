return {
  'olimorris/codecompanion.nvim',
  ---@module "codecompanion"
  ---@type CodeCompanion.Config
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = 'copilot',
          model = 'gpt-5',
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'j-hui/fidget.nvim',
    {
      'Davidyz/VectorCode',
      version = '*',
      build = 'uv tool upgrade vectorcode',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  init = function()
    require('utils.fidget-spinner'):init()
  end,
}
