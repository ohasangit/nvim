require('config.options')
require('config.keymaps')

local lsp = require('config.lsp')
lsp.init()

require('config.lazy')
-- require('config.autocmds')
