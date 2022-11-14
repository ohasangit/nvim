-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  sync_root_with_cwd = true,
  reload_on_bufenter = true,
  view = {
    width = 50,
    side = "right",
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
  renderer = {
    icons = {
      git_placement = 'after',
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
