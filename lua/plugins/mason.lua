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
      {
        'neovim/nvim-lspconfig',
        branch = 'master',
        dependencies = {
          { 'folke/neodev.nvim', opts = {} }
        }
      },
      { 'cmp-nvim-lsp' }
    },
    init = function()

      local on_attach = function(client, bufnr)
        Lsp.lsp_keymaps(bufnr)
        Lsp.lsp_highlight_document(client, bufnr)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_lspconfig = require('mason-lspconfig')
      local cfg = require("yaml-companion").setup()

      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities
          })
        end,
        ['yamlls'] = function()
          require('lspconfig').yamlls.setup(cfg)
        end,
        ['marksman'] = function()
          require('lspconfig').marksman.setup({
            on_attach = on_attach,
          })
        end,
      })
    end,
    config = true
  },
}
