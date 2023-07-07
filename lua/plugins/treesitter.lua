return {
  'nvim-treesitter/nvim-treesitter',
  branch = "master",
  build = ":TSUpdate",
  opts = {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = {"comment"},
    highlight = {
      enable = true,
      disable = { "comment", "lua" }, -- Comment these out for now since they have really bad performance
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    rainbow = { enable = true, extended_mode = true }
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
