return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine',
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup()
      end
    }
  },
  config = function()
    local function venv_status()
      if vim.bo.filetype == 'python' then
        return vim.env.VIRTUAL_ENV or 'No venv'
      end
      return ''
    end

    require('lualine').setup({
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
          },
          {
            require('lsp-progress').progress,
          },
          { venv_status }
        },
        lualine_x = {
          {
            'copilot',
            symbols = {
              status = {
                icons = {
                  enabled = ' ',
                  disabled = '󰜺 ',
                  warning = ' ',
                  unknown = ' '
                },
                hl = {
                  enabled = '#50FA7B',
                  disabled = '#6272A4',
                  warning = '#FFB86C',
                  unknown = '#FF5555',
                }
              },
              spinners = require('copilot-lualine.spinners').dots,
              spinner_color = '#50FA7B'
            }
          }, 'encoding', 'fileformat', 'filetype' },
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
    })

    -- listen lsp-progress event and refresh lualine
    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end,
}
