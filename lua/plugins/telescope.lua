return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<leader>f", "<cmd>Telescope oldfiles theme=ivy<cr>", desc = "Recent Files"},
      {"<leader>'", "<cmd>Telescope command_history theme=ivy<cr>", desc = "Command History"},
      {"<c-b>", "<cmd>Telescope buffers theme=ivy<cr>", desc = "Buffers"},
      {"<c-f>", "<cmd>Telescope git_files theme=ivy<cr>", desc = "Git files"},
      {"<leader>p", "<cmd>Telescope projects theme=ivy<cr>", desc = "Git files"},
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-n>'] = "cycle_history_next",
            ['<C-p>'] = "cycle_history_prev",
            ['<C-j>'] = "move_selection_next",
            ['<C-k>'] = "move_selection_previous",
          }
        }
      }
    }
  }
