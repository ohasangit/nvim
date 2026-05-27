return {
  'f-person/auto-dark-mode.nvim',
  opts = {
    set_light_mode = function()
      vim.api.nvim_set_option_value('background', 'light', {})
      vim.cmd.colorscheme('tokyonight')
    end,
    set_dark_mode = function()
      vim.api.nvim_set_option_value('background', 'dark', {})
      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
