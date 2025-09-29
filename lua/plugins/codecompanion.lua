return {
  'olimorris/codecompanion.nvim',
  ---@module "codecompanion"
  ---@type CodeCompanion.Config
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat toggle<cr>', desc = 'Toggle CodeCompanion Chat' },
  },
  opts = {
    opts = {
      log_level = 'DEBUG',
    },
    adapters = {
      http = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            raw = { '--http1.1', '--max-time', '25' },
            opts = { stream = false },
          })
        end,
        -- opts = {
        --   proxy = 'socks5://127.0.0.1:9999',
        --   allow_insecure = false,
        -- },
      },
    },
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
