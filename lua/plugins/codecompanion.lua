return {
  'olimorris/codecompanion.nvim',
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat toggle<cr>', desc = 'Toggle CodeCompanion Chat' },
  },
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
            opts = { stream = false },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = 'copilot',
        tools = {
          opts = {
            auto_submit_errors = true,
            auto_submit_success = true,
          },
          run_command = {
            opts = {
              require_approval_before = false,
              require_cmd_approval = false,
            },
          },
          read_file = {
            opts = {
              require_approval_before = false,
            },
          },
        },
      },
    },
    -- Native MCP support (added in codecompanion.nvim #2549/#2764). Replaces the
    -- mcphub.nvim extension: mcphub's tool configs nest `schema` under
    -- `callback.schema`, but this codecompanion version's `Tools.resolve()` only
    -- unwraps `callback` when it's a function, so mcphub-provided tools were
    -- silently never attached to any request (visible as `Tools: {}` in
    -- codecompanion.log on every request, even with @server groups referenced).
    -- Server definitions mirror ~/.config/mcphub/servers.json (the `git` server
    -- is omitted - it was already broken there too, missing REPOSITORY_PATH).
    -- Remote `npx mcp-remote <url>` servers mirror the claude.ai connectors
    -- from `claude mcp list`; several need a one-time OAuth login (mcp-remote
    -- opens a browser and caches the token) before their tools will resolve.
    mcp = {
      servers = {
        asana = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.asana.com/sse' },
        },
        atlassian = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.atlassian.com/v1/mcp' },
          -- Some atlassian tool schemas use JSON Schema constructs (e.g. a
          -- `fields`/`oneOf` union missing an explicit `type`) that Copilot's
          -- strict function-calling validation rejects, which fails the ENTIRE
          -- request (all tools share one array). Disable the offending ones.
          tool_overrides = {
            editJiraIssue = { enabled = false },
            createJiraIssue = { enabled = false },
            transitionJiraIssue = { enabled = false },
          },
        },
        canva = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.canva.com/mcp' },
        },
        datadog = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.datadoghq.com/api/unstable/mcp-server/mcp' },
        },
        datalake = {
          cmd = {
            '/home/ohasan/code/torc-agentic-dev-kit/mcp/datalake/mcp_server/.venv/bin/python',
            '-m',
            'datalake_mcp',
          },
        },
        fetch = {
          cmd = { 'uvx', 'mcp-server-fetch' },
          -- `fetch`'s only tool declares its `url` param as JSON Schema format
          -- "uri", which Copilot's strict validation rejects outright.
          tool_overrides = {
            fetch = { enabled = false },
          },
        },
        figma = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.figma.com/mcp' },
        },
        github = {
          cmd = {
            'npx',
            'mcp-remote',
            'https://api.githubcopilot.com/mcp/',
            '--header',
            'Authorization:Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}',
          },
          env = {
            GITHUB_PERSONAL_ACCESS_TOKEN = 'GITHUB_PERSONAL_ACCESS_TOKEN',
          },
        },
        memory = {
          cmd = { 'npx', '-y', '@modelcontextprotocol/server-memory' },
        },
        microsoft365 = {
          cmd = { 'npx', 'mcp-remote', 'https://microsoft365.mcp.claude.com/mcp' },
        },
        miro = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.miro.com' },
        },
        smartsheet = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.smartsheet.com' },
        },
        zoom = {
          cmd = { 'npx', 'mcp-remote', 'https://mcp.zoom.us/mcp/zoom/streamable' },
        },
      },
      opts = {
        default_servers = { 'atlassian', 'fetch', 'github', 'memory' },
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
