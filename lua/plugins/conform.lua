return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'fixjson' },
      yaml = { 'yamlfmt' },
      markdown = { 'markdownlint', 'prettier' },
      go = { 'gofmt' },
      sh = { 'shfmt', 'shellharden' },
      html = { 'prettier' },
      css = { 'prettier' },
      python = { 'black' },
      bzl = { 'buildifier' },
    },

    default_format_opts = {
      lsp_format = "fallback"
    },
    notify_on_error = true,
    notify_no_formatters = true,
    formatters = {
      prettier = {
        command = "prettier",
        args = { "--write", "--print-width", "80", "--prose-wrap", "always", "--stdin-filepath", "$FILENAME" },
      }
    }
  }
}
