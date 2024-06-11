return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    null_ls.setup({
      debug = false,
      sources = {
        formatting.prettier.with({ extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } }),
        formatting.shfmt,
        formatting.fixjson,
        formatting.black.with({ extra_args = { '--line-length', '120' } }),
        formatting.shellharden,
        formatting.taplo,
        formatting.yamlfmt,
        formatting.buildifier,
        formatting.gofmt,
        formatting.npm_groovy_lint,
        diagnostics.cspell.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
          extra_args = { '--config', vim.fn.stdpath('config') .. '/cspell.json' },
          disabled_filetypes = { "NvimTree" }
        }),
        diagnostics.hadolint,
        diagnostics.jsonlint,
        diagnostics.actionlint.with({ extra_args = { '-ignore', 'customer-tools' } }),
        diagnostics.commitlint,
        diagnostics.tfsec,
        diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
        diagnostics.buildifier,
        diagnostics.golangci_lint,
        diagnostics.npm_groovy_lint,
        code_actions.gitsigns,
        code_actions.shellcheck,
      },
    })
  end,
}
