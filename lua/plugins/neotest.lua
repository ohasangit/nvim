return {
  'nvim-neotest/neotest',
  keys = {
    { '<leader>tt', '<cmd>lua require("neotest").run.run()<cr>',                     desc = 'Run test under cursor' },
    { '<leader>tw', '<cmd>lua require("neotest").watch.watch()<cr>',                 desc = 'Watch test under cursor' },
    { '<leader>ta', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>',   desc = 'Run all tests in file' },
    { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>',              desc = 'Toggle test summary' },
    { '<leader>tr', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', desc = 'Open test output' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-python'
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require('neotest-python')
      }
    }
  end
}
