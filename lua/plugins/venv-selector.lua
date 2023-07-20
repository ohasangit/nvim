return {
  'linux-cultist/venv-selector.nvim',
  keys = {{
		'<leader>vs', '<cmd>:VenvSelect<cr>', desc = 'Select Virtualenv'
  }},
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
  opts = {
    search = false
  }
}
