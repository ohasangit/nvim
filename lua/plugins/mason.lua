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
      local function lsp_highlight_document(client, bufnr)
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.documentHighlightProvider then
          -- vim.api.nvim_create_augroup("lsp_highlight_document")
          -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_highlight_document" })
          -- vim.api.nvim_create_autocmd("CursorHold", {
          --   buffer = 0,
          --   callback = vim.lsp.buf.document_highlight(),
          --   group = "lsp_highlight_document",
          -- })
          -- vim.api.nvim_create_autocmd("CursorMoved", {
          --   buffer = 0,
          --   callback = vim.lsp.buf.clear_references(),
          --   group = "lsp_highlight_document"
          -- })


          vim.api.nvim_exec(
            [[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
            false
          )
        end
      end

      local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
          opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
          opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>af', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
      end


      local on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        lsp_highlight_document(client, bufnr)
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
