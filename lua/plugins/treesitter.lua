local languages = {
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
  'json5',
  'yaml',
  'terraform',
  'javascript',
  'typescript',
  'markdown',
  'markdown_inline',
  'groovy',
  'toml',
  'starlark',
  'vimdoc',
  'go',
}

local highlight_filetypes = {
  'lua',
  'python',
  'json',
  'bash',
  'c',
  'cmake',
  'cpp',
  'dockerfile',
  'diff',
  'gitconfig',
  'gitrebase',
  'gitcommit',
  'gitignore',
  'gitattributes',
  'http',
  'jq',
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
  'go',
}

local indent_filetypes = {
  'lua',
  'python',
  'json',
  'bash',
  'c',
  'cmake',
  'cpp',
  'dockerfile',
  'json5',
  'terraform',
  'javascript',
  'typescript',
  'toml',
  'starlark',
  'go',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    config = function()
      local nts = require('nvim-treesitter')

      nts.setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      nts.install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Enable treesitter highlighting',
        pattern = highlight_filetypes,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Enable treesitter indentation',
        pattern = indent_filetypes,
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
  },
}
