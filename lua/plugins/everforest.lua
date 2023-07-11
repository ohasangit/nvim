return {
  'sainnhe/everforest',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = true,
  init = function()
    vim.cmd([[
    if has('termguicolors')
      set termguicolors
    endif
    let g:everforest_background = 'hard'
    let g:everforest_better_performance = 1
    " let g:everforest_transparent_background = 2
    let g:everforest_dim_inactive_windows = 2
    let g:everforest_ui_contrast = 'high'
    let g:everforest_show_eob = 0

    colorscheme everforest
    ]])
  end,
}
