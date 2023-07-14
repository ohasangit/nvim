return {
  'someone-stole-my-name/yaml-companion.nvim',
  branch = 'main',
  ft = { 'yaml' },
  keys = {
    { '<leader>y', '<cmd>Telescope yaml_schema<cr>', desc = 'Select yaml schema', noremap = true },
  },
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("telescope").load_extension("yaml_schema")
  end,
}
