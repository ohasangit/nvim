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

    -- CodeCompanion spinner component (shows while an LLM request is in-flight)
    local CodeCompanionSpinner = require('lualine.component'):extend()
    CodeCompanionSpinner.processing = false
    CodeCompanionSpinner.spinner_index = 0
    local cc_spinner_symbols = { '⠋','⠙','⠹','⠸','⠼','⠴','⠦','⠧','⠇','⠏' }

    function CodeCompanionSpinner:init(options)
      CodeCompanionSpinner.super.init(self, options)
      local group = vim.api.nvim_create_augroup('CodeCompanionLualine', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'CodeCompanionRequest*',
        callback = function(ev)
          if ev.match == 'CodeCompanionRequestStarted' then
            self.processing = true
          elseif ev.match == 'CodeCompanionRequestFinished' then
            self.processing = false
          end
          -- force statusline redraw to advance spinner / clear it
          require('lualine').refresh()
        end,
      })
    end

    function CodeCompanionSpinner:update_status()
      if self.processing then
        self.spinner_index = (self.spinner_index % #cc_spinner_symbols) + 1
        return cc_spinner_symbols[self.spinner_index] .. ' CC'
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
          CodeCompanionSpinner,
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
