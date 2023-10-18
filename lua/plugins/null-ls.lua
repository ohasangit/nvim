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
        formatting.markdownlint,
        formatting.taplo,
        formatting.yamlfmt,
        diagnostics.shellcheck,
        diagnostics.hadolint,
        diagnostics.markdownlint,
        diagnostics.jsonlint,
        diagnostics.actionlint,
        diagnostics.codespell,
        diagnostics.commitlint,
        diagnostics.tfsec,
        diagnostics.trail_space,
        diagnostics.buildifier,
        code_actions.gitsigns,
        code_actions.refactoring,
        code_actions.shellcheck,
      },
    })
  end,
}
