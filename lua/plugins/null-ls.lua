return {
  'jose-elias-alvarez/null-ls.nvim',
  enabled = false,
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    null_ls.setup({
      debug = false,
      sources = {
        diagnostics.tfsec,
        diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
        diagnostics.golangci_lint,
        diagnostics.npm_groovy_lint,
      },
    })
  end,
}
