return {
  "numine777/py-bazel.nvim",
  config = function()
    require("py-bazel").setup()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  enabled = false,
}
