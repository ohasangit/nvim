return {
  'tyru/open-browser.vim',
  keys = {
    { '<leader>goo', ':OpenBrowserSmartSearch ', desc = 'Browser search', silent = true },
    {
      '<c-g>',
      '<Plug>(openbrowser-smart-search)',
      desc = 'Browser search word under cursor',
      silent = true,
      noremap = true
    },
  },
}
