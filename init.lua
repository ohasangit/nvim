require('config.neovide')
require('config.options')
require('config.keymaps')
require('config.lsp')
require('config.lazy')
require('config.autocmds')
require('utils.keymap-functions')
require('utils.git')

local success = pcall(require('config.api-keys'))
if not success then
  print('No API keys found. Please create a config/api-keys.lua file with your API keys.')
end
