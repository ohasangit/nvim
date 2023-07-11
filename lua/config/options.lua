vim.g.mapleader = ' '

local opt = vim.opt

opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.completeopt = 'menuone,noselect'
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 2
opt.pumblend = 10
opt.pumheight = 10
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ c = true })
opt.showmode = false   -- Statusline plugin replaces this
opt.showtabline = 0    -- Hide tabs
opt.sidescrolloff = 8
opt.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.undofile = true
opt.updatetime = 300
opt.wrap = false

vim.g.python3_host_prog = '/usr/bin/python3'

if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
end
