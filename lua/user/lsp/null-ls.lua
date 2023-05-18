local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.stylua,
    formatting.shfmt,
    formatting.fixjson,
    formatting.black.with({ extra_args = { "--line-length", "120" } }),
    formatting.shellharden,
    formatting.markdownlint,
    formatting.taplo,
    formatting.yamlfmt,
    diagnostics.shellcheck,
    diagnostics.hadolint,
    diagnostics.markdownlint,
    diagnostics.jsonlint,
    diagnostics.actionlint,
    diagnostics.write_good,
    diagnostics.codespell,
    diagnostics.commitlint,
    diagnostics.tfsec,
    -- diagnostics.todo_comments,
    diagnostics.trail_space,
    -- diagnostics.yamllint,
    -- diagnostics.vacuum,
    code_actions.gitsigns,
    -- code_actions.prettier,
    code_actions.refactoring,
    code_actions.shellcheck,
    -- hover.printenv,
    -- hover.dictionary,
  },
})
