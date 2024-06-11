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
    init = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_lspconfig = require('mason-lspconfig')
      local cfg = require("yaml-companion").setup()

      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = Lsp.on_attach,
            capabilities = capabilities
          })
        end,
        ['yamlls'] = function()
          require('lspconfig').yamlls.setup(cfg)
        end,
        ['marksman'] = function()
          require('lspconfig').marksman.setup({
            on_attach = Lsp.on_attach,
          })
        end,
        ['clangd'] = function()
          require("lspconfig").clangd.setup {
            on_attach = Lsp.on_attach,
            capabilities = capabilities,
            cmd = {
              "clangd",
              "--offset-encoding=utf-16",
            },
          }
        end,
        ['tailwindcss'] = function()
          require('lspconfig').tailwindcss.setup {
            on_attach = Lsp.on_attach,
            capabilities = capabilities,
            filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } -- Disable for markdown
          }
        end,
      })
    end,
    opts = {
      ensure_installed = {
        'bashls',
        'bzl',
        'docker_compose_language_service',
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
        'tsserver',
        'yamlls'
      },
    },
  }
}
