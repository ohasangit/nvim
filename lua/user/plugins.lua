local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "dhruvmanila/telescope-bookmarks.nvim", requires = { "tami5/sqlite.lua", "tyru/open-browser.vim" } }
  use { "ahmedkhalf/project.nvim", config = function() require("project_nvim").setup {} end }

  -- Treesitter
  --use {
  --"nvim-treesitter/nvim-treesitter",
  --run = ":TSUpdate",
  --}
  --use "p00f/nvim-ts-rainbow"

  -- Git
  use "tpope/vim-fugitive"
  use "ruifm/gitlinker.nvim"
  use "lewis6991/gitsigns.nvim"

  -- Scrolling
  use {
    "wfxr/minimap.vim",
    run = "cargo install --locked code-minimap",
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 0")
      vim.cmd("let g:minimap_git_colors = 1")
      vim.cmd("let g:minimap_highlight_search = 1")
      vim.cmd("let g:minimap_highlight_range = 1")
      vim.cmd(":highlight minimapCursor guibg=#1D1F21 guifg=magenta")
      vim.cmd(":highlight minimapRange guibg=#282A2E guifg=white")
      vim.cmd(":highlight minimapDiffAdded guibg=#1D1F21 guifg=#587c0c")
      vim.cmd(":highlight minimapRemoved guibg=#1D1F21 guifg=#94151b")
      vim.cmd(":highlight minimapDiffLine guibg=#1D1F21 guifg=#0c7d9d")
      vim.cmd(":highlight minimapCursorDiffAdded guibg=#1D1F21 guifg=#A4E400")
      vim.cmd(":highlight minimapCursorDiffRemoved guibg=#1D1F21 guifg=red")
      vim.cmd(":highlight minimapCursorDiffLine guibg=#1D1F21 guifg=#82A3BF")
      vim.cmd(":highlight minimapRangeDiffAdded guibg=#282A2E guifg=#587c0c")
      vim.cmd(":highlight minimapRangeDiffRemoved guibg=#282A2E guifg=#94151b")
      vim.cmd(":highlight minimapRangeDiffLine guibg=#282A2E guifg=#0c7d9d")
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
