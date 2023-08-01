return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<leader>db',
        '<cmd>lua require"dap".toggle_breakpoint()<cr>',
        desc =
        'Toggle Breakpoint'
      },
      {
        '<leader>dB',
        '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint Condition: "))<cr>',
        desc =
        'Set Conditional Breakpoint'
      },
      {
        '<leader>dc',
        '<cmd>lua require"dap".continue()<cr>',
        desc =
        'DAP Continue'
      },
      {
        '<leader>ds',
        '<cmd>lua require"dap".step_into()<cr>',
        desc =
        'DAP Step Into'
      },
      {
        '<leader><leader>',
        '<cmd>lua require"dap".step_over()<cr>',
        desc =
        'DAP Step Over'
      },
      {
        '<leader>do',
        '<cmd>lua require"dap".step_out()<cr>',
        desc =
        'DAP Step Out'
      },
      {
        '<leader>dh',
        '<cmd>lua require"dap".run_to_cursor()<cr>',
        desc =
        'DAP Run to Cursor'
      },
      {
        '<leader>df',
        '<cmd>lua require"dap".focus_frame()<cr>',
        desc =
        'DAP focus frame'
      },
      {
        '<leader>dr',
        '<cmd>lua require"dap".restart()<cr>',
        desc =
        'DAP Restart'
      },
      {
        '<leader>dR',
        '<cmd>lua require"dap".run_last()<cr>',
        desc =
        'DAP Run Last'
      }
    },
    dependencies = {
      'theHamsta/nvim-dap-virtual-text'
    },
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    keys = {
      { '<leader>dt', '<cmd>lua require"dap-python".test_method()<cr>', desc = 'Run DAP on method under Cursor' },
    },
    ft = 'python',
    config = function()
      require('dap-python').setup()
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = {
      virt_text_win_col = 80,
    },
    lazy = true,
  },
  {
    'rcarriga/nvim-dap-ui',
    keys = {
      {
        '<leader>dd',
        '<cmd>lua require"dapui".toggle()<cr>',
        desc =
        'Toggle DAP UI'
      }
    },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
    end,
  }
}
