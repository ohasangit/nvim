return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    open_mapping = [[<C-/>]],
    responsiveness = {
      -- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
      -- instead of next to each other
      -- default = 0 which means the feature is turned off
      horizontal_breakpoint = 500,
    }
  }
}
