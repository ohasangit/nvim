return {
  'rmagatti/goto-preview',
  keys = {
    { 'gp',  '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', desc = 'Preview Definition' },
    { 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', desc = 'Preview References' },
  },
  config = function()
    require('goto-preview').setup({
      references = {
        telescope = require('telescope.themes').get_ivy()
      }
    })
  end,
}
