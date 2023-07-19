return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  tag = 'v0.9.0',
  opts = {
    ensure_installed = { 'lua', 'python', 'json', 'bash', 'c', 'cmake', 'cpp', 'dockerfile', 'diff', 'git_config',
      'git_rebase', 'gitcommit', 'gitignore', 'gitattributes', 'http', 'jq', 'json', 'json5', 'yaml', 'terraform',
      'javascript', 'markdown', 'groovy', 'toml' },
    sync_install = false,
    ignore_install = { 'comment' }, -- For some reason this parser has become super unperformant
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    rainbow = { enable = true, extended_mode = true }
  },
  -- TODO: Move to https://github.com/hiphish/rainbow-delimiters.nvim
  dependencies = {
    'p00f/nvim-ts-rainbow'
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
