return {
  "ErickKramer/nvim-ros2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function(_, opts)
    require('nvim-ros2').setup(opts)
    local parser_installed = require('nvim-treesitter.parsers').has_parser('ros2')
    if not parser_installed then
      require('nvim-treesitter.install').commands.TSInstall.run("ros2")
    end
  end,
  opts = {
    autocmds = true,
    telescope = true,
    treesitter = true,
  }
}
