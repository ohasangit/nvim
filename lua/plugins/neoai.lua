return {
  "Bryley/neoai.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>as",  desc = "Summarize text" },
    { "<leader>ag",  desc = "Generate git message" },
    { "<leader>cc",  "<cmd>NeoAI<CR>",             desc = "Toggle NeoAI" },
    { "<leader>ccc", "<cmd>NeoAIContext<CR>",      desc = "Toggle NeoAI with buffer context" },
  },
  opts = {
    models = {
      {
        name = "openai",
        model = "gpt-4",
        params = nil,
      },
    },
    shortcuts = {
      {
        name = "gitcommit",
        key = "<leader>ag",
        desc = "Generate git commit message",
        use_context = false,
        prompt = function()
          return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 50 characters or less and complies with
                    conventional commit specification:
                ]] .. vim.fn.system("git diff --cached")
        end,
        modes = { "n" },
        strip_function = nil,
      },

    }
  }
}
