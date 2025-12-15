return {
  dir = vim.fn.stdpath('config') .. '/lua/bazel',
  name = 'my-bazel',
  lazy = false,
  config = function()
    require('bazel').setup()
  end,
  keys = {
    { '<leader>bl', '<cmd>BazelBuildUnderCursor<CR>', desc = 'Bazel build' },
  },
}
