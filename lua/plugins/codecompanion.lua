return {
  'olimorris/codecompanion.nvim',
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat toggle<cr>', desc = 'Toggle CodeCompanion Chat' },
  },
  tag = 'v19.12.0',
  opts = {
    ---@module "codecompanion"
    ---@type CodeCompanion.Config
    opts = {
      log_level = 'TRACE',
    },
    adapters = {
      http = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            raw = { '--http1.1', '--max-time', '200' },
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
        adapter = 'copilot',
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = 'gh',
          save_chat_keymap = 'sc', -- manually save current chat
          auto_save = true, -- save all chats automatically
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = 'telescope', -- "telescope" | "snacks" | "fzf-lua" | "default"
          enable_logging = false,
        },
      },
      vectorcode = {
        ---@type VectorCode.CodeCompanion.ExtensionOpts
        opts = {
          tool_group = {
            -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
            enabled = true,
            -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
            -- if you use @vectorcode_vectorise, it'll be very handy to include
            -- `file_search` here.
            extras = {},
            collapse = false, -- whether the individual tools should be shown in the chat
          },
          tool_opts = {
            ---@type VectorCode.CodeCompanion.ToolOpts
            ['*'] = {},
            ---@type VectorCode.CodeCompanion.LsToolOpts
            ls = {},
            ---@type VectorCode.CodeCompanion.VectoriseToolOpts
            vectorise = {},
            ---@type VectorCode.CodeCompanion.QueryToolOpts
            query = {
              max_num = { chunk = -1, document = -1 },
              default_num = { chunk = 50, document = 10 },
              include_stderr = false,
              use_lsp = true,
              no_duplicate = true,
              chunk_mode = false,
              ---@type VectorCode.CodeCompanion.SummariseOpts
              summarise = {
                ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                enabled = false,
                adapter = nil,
                query_augmented = true,
              },
            },
            files_ls = {},
            files_rm = {},
          },
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'j-hui/fidget.nvim',
    'ravitemer/codecompanion-history.nvim',
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
