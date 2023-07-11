return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#ff9e64' },
        },
      },
      lualine_c = {
        {
          'filename', path = 3
        }
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename', path = 3
        }
      },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  }
}
