return {
  {
    'williamboman/mason.nvim',
    keys = {
      { '<leader>hk', '<cmd>Mason<cr>', desc = 'LSP Manager' },
    },
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig', },
      { 'cmp-nvim-lsp' }
    },
    opts = {
      ensure_installed = {
        'bashls',
        'bzl',
        'docker_compose_language_service',
        'clangd',
        'dockerls',
        'eslint',
        'gopls',
        'groovyls',
        'jsonls',
        'lua_ls',
        'pyright',
        'remark_ls',
        'rust_analyzer',
        'tailwindcss',
        'taplo',
        'terraformls',
        'tflint',
        'yamlls'
      },
    },
  }
}
