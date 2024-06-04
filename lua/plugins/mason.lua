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
    ensure_installed = {
      'pyright'
    },
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
      })
    end,
    config = true
  },
}
