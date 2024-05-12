return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'lua',
      'python',
      'json',
      'bash',
      'c',
      'cmake',
      'cpp',
      'dockerfile',
      'diff',
      'git_config',
      'git_rebase',
      'gitcommit',
      'gitignore',
      'gitattributes',
      'http',
      'jq',
      'json',
      'jsonc',
      'json5',
      'yaml',
      'terraform',
      'javascript',
      'typescript',
      'markdown',
      'groovy',
      'toml',
      'starlark',
      'vimdoc',
      'go'
    },
    sync_install = false,
    ignore_install = { 'comment' }, -- For some reason this parser has become super unperformant
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
      disable = { 'yaml' }
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
