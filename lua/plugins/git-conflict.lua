return {
  'akinsho/git-conflict.nvim',
  opts = {
    -- disable_diagnostics = true calls vim.diagnostic.disable(), which was
    -- removed in Nvim 0.12. Leave it false (the default) until the plugin
    -- is updated to use vim.diagnostic.enable(false, ...).
    disable_diagnostics = false,
  },
}
