return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      sh = { "shellcheck" },
      lua = { "luacheck" },
      dockerfile = { "hadolint" },
      json = { "jsonlint" },
      -- gitcommit = { "commitlint" },
      ghaction = { "actionlint" },
      -- go = { "golangcilint" },
    }

    -- TODO: Figure out how to configure action lint properly
    lint.linters = {
      actionlint = {
        args = { "-ignore", "customer-tools" },
        cmd = "actionlint",
      },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
