return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {"<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" }
  },
  opts = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- You will need to insert "your code goes here" for any mappings with a custom action_cb
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))

    end

    return {
      on_attach = on_attach,
      sync_root_with_cwd = true,
      reload_on_bufenter = true,
      view = {
        width = 50,
        side = "right",
      },
      renderer = {
        icons = {
          git_placement = "after",
          glyphs = {
            git = {
              unstaged = "",
              staged = "S",
              untracked = "U",
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          resize_window = false,
          window_picker = {
            enable = true,
          },
        },
      },
    }
  end,
}
