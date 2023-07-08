return {
  'folke/trouble.nvim',
  branch = 'main',
  keys = {
    { '<leader>di', '<cmd>TroubleToggle<cr>',                       desc = 'Trouble Toggle' },
    { '<leader>dw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Trouble toggle workspace' },
    { '<leader>di', '<cmd>TroubleToggle document_diagnostics<cr>',  desc = 'Trouble toggle document' },
    { '<leader>dl', '<cmd>TroubleToggle loclist<cr>',               desc = 'Trouble toggle loclist' },
    { '<leader>dq', '<cmd>TroubleToggle quickfix<cr>',              desc = 'Trouble toggle quickfix' },
    { '<leader>dg', '<cmd>TroubleToggle lsp_references<cr>',        desc = 'Trouble toggle lsp references' }
  },
  opts = {
    height = 25,
    use_diagnostic_signs = true,
  }
}
