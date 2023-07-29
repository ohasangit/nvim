return packer.startup(function(use)
  use('ellisonleao/glow.nvim')
  use({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' })
  use({ 'ckipp01/nvim-jenkinsfile-linter', requires = { 'nvim-lua/plenary.nvim' } })
  use('folke/neodev.nvim')

  -- Telescope
  use('nvim-telescope/telescope.nvim')
  use('nvim-telescope/telescope-media-files.nvim')
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'dhruvmanila/telescope-bookmarks.nvim', requires = { 'tami5/sqlite.lua', 'tyru/open-browser.vim' } })
  use({ 'ahmedkhalf/project.nvim' })
  use({ 'nvim-telescope/telescope-dap.nvim' })

  use({
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup()
    end,
  })

  -- DAP
  use('mfussenegger/nvim-dap')
  use({
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui').setup()
    end,
  })
  -- use('jay-babu/mason-nvim-dap.nvim')
  use('mfussenegger/nvim-dap-python')
  use('theHamsta/nvim-dap-virtual-text')
