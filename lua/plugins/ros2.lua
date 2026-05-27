return {
  'ErickKramer/nvim-ros2',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    picker = 'telescope',
    autocmds = true,
    treesitter = true,
    tuner = true, -- Enables the :RosTune command and hardware proxy
    tuner_match_mode = 'smart', -- "smart" (algorithm), "simple" (root keys), or "all" (skip filter)
    tuner_open_mode = 'hide',
  },
}
