-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "lewis6991/impatient.nvim"
  use "ethanholz/nvim-lastplace"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "ellisonleao/glow.nvim"
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }
  use "folke/which-key.nvim"
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use({ 'ckipp01/nvim-jenkinsfile-linter', requires = { "nvim-lua/plenary.nvim" } })

  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "williamboman/mason.nvim"
  use { "williamboman/mason-lspconfig.nvim" }
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use { 'neovim/nvim-lspconfig' } -- Configurations for Nvim LSP
  use {
    'junnplus/lsp-setup.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }
  }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "dhruvmanila/telescope-bookmarks.nvim", requires = { "tami5/sqlite.lua", "tyru/open-browser.vim" } }
  use { "ahmedkhalf/project.nvim", config = function() require("project_nvim").setup {} end }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  -- Git
  use "tpope/vim-fugitive"
  use "ruifm/gitlinker.nvim"
  use "lewis6991/gitsigns.nvim"
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }

  -- Web Development
  use "ray-x/web-tools.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
