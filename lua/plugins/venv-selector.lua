return {
  'linux-cultist/venv-selector.nvim',
  keys = {
    { '<leader>vs', '<cmd>:VenvSelect<cr>',       desc = 'Select Virtualenv' },
    { '<leader>vc', '<cmd>:VenvSelectCached<cr>', desc = 'Select Cached Virtualenv' }
  },
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
    'mfussenegger/nvim-dap-python'
  },
  opts = {
    search = false,
    dap_enabled = true,
  },
  config = function(_, opts)
    --- @param venv_path string A string containing the absolute path to selected virtualenv
    --- @param venv_python string A string containing the absolute path to python binary in selected venv
    local pyright_hook = function(venv_path, venv_python)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.api.nvim_clear_autocmds({ buffer = vim.api.nvim_get_current_buf(), group = "lsp_document_highlight" })
      require('lspconfig').pyright.setup({
        on_attach = Lsp.on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = venv_python,
          },
        },
      })
    end
    opts['changed_venv_hooks'] = { pyright_hook }
    require('venv-selector').setup(opts)
  end,
}
