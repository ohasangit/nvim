return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  tag = 'v8.3.0',
  config = function()
    require('render-markdown').setup({
      file_types = { 'markdown', 'md', 'help', 'copilot-chat' },
    })
  end,
}
