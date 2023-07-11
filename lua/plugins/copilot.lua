return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false, },
      suggestion = { enabled = false, },
      filetypes = {
        gitcommit = true,
        yaml = true,
        markdown = true,
      },
    }
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = true
  }
}
