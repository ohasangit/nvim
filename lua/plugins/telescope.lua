return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>f',  '<cmd>Telescope oldfiles theme=ivy<cr>',            desc = 'Recent Files' },
      { '<c-f>',      '<cmd>Telescope git_files theme=ivy<cr>',           desc = 'Git files' },
      { '<c-b>',      '<cmd>Telescope buffers theme=ivy<cr>',             desc = 'Buffers' },
      { '<leader>p',  '<cmd>Telescope projects theme=ivy<cr>',            desc = 'Projects' },
      { '<leader>\'', '<cmd>Telescope command_history theme=ivy<cr>',     desc = 'Command History' },
      { '<c-c>',      '<cmd>Telescope commands theme=ivy<cr>',            desc = 'Commands' },
      { '<leader>/',  '<cmd>Telescope live_grep theme=ivy<cr>',           desc = 'Grep word under cursor' },
      { '<leader>\\', '<cmd>Telescope grep_string theme=ivy<cr>',         desc = 'Grep string' },
      { '<leader>hh', '<cmd>Telescope help_tags theme=ivy<cr>',           desc = 'Help docs' },
      { '<c-p>',      '<cmd>Telescope registers theme=ivy<cr>',           desc = 'Registers' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>',                    desc = 'Git status' },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>',                  desc = 'Git branch' },
      { '<leader>gl', '<cmd>Telescope git_bcommits<cr>',                  desc = 'Git buffer commits' },
      { '<leader>gL', '<cmd>Telescope git_commits<cr>',                   desc = 'Git commits' },
      { '<leader>gS', '<cmd>Telescope git_stash<cr>',                     desc = 'Git stash' },
      { '<leader>r',  '<cmd>Telescope lsp_references<cr>',                desc = 'LSP references' },
      { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>',          desc = 'LSP document symbols' },
      { '<leader>lw', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'LSP dynamic workspace symbols' },
      { '<leader>m',  '<cmd>Telescope keymaps<cr>',                       desc = 'Keymaps' },
    },
    opts = {
      defaults = {
        path_display = { 'absolute' },
        mappings = {
          i = {
            ['<C-n>'] = 'cycle_history_next',
            ['<C-p>'] = 'cycle_history_prev',
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
          }
        }
      },
      extensions = {
        media_files = {
          find_cmd = 'rg',
        },
      },
    },
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    keys = {
      { '<leader>mf', '<cmd>Telescope media_files theme=ivy<cr>', desc = 'Media files' },
    },
    config = function()
      require 'telescope'.load_extension('media_files')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require 'telescope'.load_extension('fzf')
    end,
  },
  {
    'dhruvmanila/browser-bookmarks.nvim',
    keys = {
      { '<leader>bb', '<cmd>Telescope bookmarks<cr>', desc = 'Browser bookmarks' },
    },
    config = function()
      require 'browser_bookmarks'.setup {
          selected_browser = 'chrome',
          url_open_plugin = 'open_browser',
          full_path = false,
      }
      require 'telescope'.load_extension('bookmarks')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tyru/open-browser.vim'
    }
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    config = function()
      require 'telescope'.load_extension('dap')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    }
  },
  {
    'isak102/telescope-git-file-history.nvim',
    config = function()
      require 'telescope'.load_extension('git_file_history')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>gh', '<cmd>Telescope git_file_history<cr>', desc = 'Git File History' },
    }
  }
}
