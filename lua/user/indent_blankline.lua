vim.opt.termguicolors = true
-- vim.cmd([[highlight IndentBlanklineContextStart guisp=#00FF00 gui=underdouble]])
vim.opt.list = true

require('indent_blankline').setup({
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
})
