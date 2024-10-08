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
    notify_user_on_activate = false,
  },
  config = function(_, opts)
    --- @param venv_path string A string containing the absolute path to selected virtualenv
    --- @param venv_python string A string containing the absolute path to python binary in selected venv
    local pyright_hook = function(venv_path, venv_python)
      local lspconfig = require('lspconfig')

      if lspconfig.pyright.manager.config.settings.python.pythonPath == venv_python then
        return
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.api.nvim_clear_autocmds({ buffer = vim.api.nvim_get_current_buf(), group = "lsp_document_highlight" })
      local notify = require('notify')
      notify.notify('Virtualenv changed to ' .. venv_path, 'info', { title = 'VenvSelector' })
      lspconfig.pyright.setup({
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
