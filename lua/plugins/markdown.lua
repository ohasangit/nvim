return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      file_types = { 'markdown', 'md', 'help', 'copilot-chat' },
    })
  end,
}
