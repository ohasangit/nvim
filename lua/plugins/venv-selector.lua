return {
  'linux-cultist/venv-selector.nvim',
  keys = {
    { '<leader>vs', '<cmd>:VenvSelect<cr>', desc = 'Select Virtualenv' },
    { '<leader>vc', '<cmd>:VenvSelectCached<cr>', desc = 'Select Cached Virtualenv' }
  },
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
  opts = {
    search = false,
  },
  config = function(_, opts)
    local venv_selector = require('venv-selector')

    --- @param venv_path string A string containing the absolute path to selected virtualenv
    --- @param venv_python string A string containing the absolute path to python binary in selected venv
    local pyright_hook = function(venv_path, venv_python)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
