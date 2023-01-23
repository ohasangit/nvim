-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

return packer.startup(function(use)
  use('wbthomason/packer.nvim') -- Have packer manage itself
  use('nvim-lua/popup.nvim') -- An implementation of the Popup API from vim in Neovim
  use('nvim-lua/plenary.nvim') -- Useful lua functions used ny lots of plugins
  use('windwp/nvim-autopairs') -- Autopairs, integrates with both cmp and treesitter
  use('numToStr/Comment.nvim') -- Easily comment stuff
  use('lewis6991/impatient.nvim')
  use('ethanholz/nvim-lastplace')
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')
  use('ellisonleao/glow.nvim')
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })
  use('folke/which-key.nvim')
  use({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' })
  use({ 'ckipp01/nvim-jenkinsfile-linter', requires = { 'nvim-lua/plenary.nvim' } })
  use('lukas-reineke/indent-blankline.nvim')
  use('NvChad/nvim-colorizer.lua')
  use('eandrju/cellular-automaton.nvim')
  use({
    'jackMort/ChatGPT.nvim',
    config = function()
      require('chatgpt').setup({
        -- optional configuration
      })
    end,
    requires = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  })
  -- Colorschemes
  use('folke/tokyonight.nvim')

  -- cmp plugins
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('saadparwaiz1/cmp_luasnip')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')
  use('petertriho/cmp-git')

  -- snippets
  use('L3MON4D3/LuaSnip')
  use('rafamadriz/friendly-snippets')

  -- LSP
  use('williamboman/mason.nvim')
  use({ 'williamboman/mason-lspconfig.nvim' })
  use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters
  use({ 'neovim/nvim-lspconfig' }) -- Configurations for Nvim LSP
  use({
    'junnplus/lsp-setup.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  })

  -- Telescope
  use('nvim-telescope/telescope.nvim')
  use('nvim-telescope/telescope-media-files.nvim')
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'dhruvmanila/telescope-bookmarks.nvim', requires = { 'tami5/sqlite.lua', 'tyru/open-browser.vim' } })
  use({ 'ahmedkhalf/project.nvim' })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })
  use('p00f/nvim-ts-rainbow')
  use({
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup()
    end,
  })

  -- Git
  use('tpope/vim-fugitive')
  use('ruifm/gitlinker.nvim')
  use('lewis6991/gitsigns.nvim')
  use({
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  })
  use('github/copilot.vim')

  -- Web Development
  use('ray-x/web-tools.nvim')

  -- DAP
  use('mfussenegger/nvim-dap')
  use({
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui').setup()
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
