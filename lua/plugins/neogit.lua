return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim'
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
  },
  config = function()
    require("neogit").setup({
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      disable_hint = true,
      integrations = {
        diffview = true
      },
    })
  end
}
