return {
  'rmagatti/goto-preview',
  keys = { 'gp', 'gpr' },
  config = function()
    require("goto-preview").setup({
      references = {
        telescope = require("telescope.themes").get_ivy()
      }
    })   -- May not need this in the future: https://github.com/rmagatti/goto-preview/issues/88
    vim.keymap.set('n', 'gp', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>',
      { noremap = true, silent = true })
    vim.keymap.set('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>',
      { noremap = true, silent = true })
  end,
}
