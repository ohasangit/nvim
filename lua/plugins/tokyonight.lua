return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme('tokyonight')
  end,
  opts = function()
    return {
      style = "moon",
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        functions = { bold = true },
        comments = { italic = true },
        keywords = { italic = true },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent",                               -- style for sidebars, see below
        floats = "transparent",                                 -- style for floating windows
      },
      sidebars = { "qf", "help", "terminal", "mason", "lazy" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      dim_inactive = true,
      lualine_bold = true,
      cache = true,

      ---@type table<string, boolean|{enabled:boolean}>
      plugins = {
        auto = true,
      },

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param hl Highlights
      ---@param c ColorScheme
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.IndentBlanklineIndent1 = {
          bg = c.bg_statusline,
        }
        hl.IndentBlanklineIndent2 = {
          bg = c.black,
        }
      end,
    }
  end
}
