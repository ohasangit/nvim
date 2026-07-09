return {
  'ravitemer/mcphub.nvim',
  branch = 'main',
  version = false,
  -- Keeps the `mcp-hub` binary in sync with the plugin. A binary/plugin version
  -- mismatch (e.g. 4.2.0 vs required 4.2.1) makes the hub restart-loop and
  -- silently registers empty per-server tool groups (@github etc.) in CodeCompanion.
  build = 'npm install -g mcp-hub@latest',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('mcphub').setup()
  end,
}
