return {
  'ahmedkhalf/project.nvim',
  lazy = false,
  keys = {
    { '<leader>p', '<cmd>Telescope projects<cr>', desc = 'Projects' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('project_nvim').setup {
      detection_methods = { 'pattern', 'lsp', 'cwd' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'Cargo.toml' },
      show_hidden = true,
      exclude_dirs = { 'node_modules', '.git' },
    }
    require('telescope').load_extension('projects')
  end
}
