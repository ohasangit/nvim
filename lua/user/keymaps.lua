local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Quick Saving --
keymap("n", "<leader>w", ":w<cr>", opts)

-- Quick Window Close/Exit --
keymap("n", "<leader>q", ":q<cr>", opts)

-- Quick Buffer Close --
keymap("n", "<leader>bd", ":bd<cr>", opts)

-- Quick Commands --
keymap("n", "<leader>;", ":", { noremap = true })

-- Remove Highlighting
keymap("n", "<leader><cr>", ":noh<cr>", opts)

-- Remove Highlighting
keymap("n", "<leader>l", ":set invnumber<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+0<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope --
local theme = "theme=ivy"
keymap("n", "<leader>f", "<cmd>Telescope oldfiles " .. theme .. "<cr>", opts)
keymap("n", "<leader>'", "<cmd>Telescope command_history " .. theme .. "<cr>", opts)
keymap("n", "<c-b>", "<cmd>Telescope buffers " .. theme .. "<cr>", opts)
keymap("n", "<c-f>", "<cmd>Telescope git_files " .. theme .. "<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects  " .. theme .. "<cr>", opts)
keymap("n", "<leader>/", "<cmd>Telescope live_grep " .. theme .. "<cr>", opts)
keymap("n", "<leader>\\", "<cmd>Telescope grep_string " .. theme .. "<cr>", opts)
keymap("n", "<c-c>", "<cmd>Telescope commands " .. theme .. "<cr>", opts)
keymap("n", "<leader>hh", "<cmd>Telescope help_tags " .. theme .. "<cr>", opts)
keymap("n", "<c-p>", "<cmd>Telescope registers " .. theme .. "<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
keymap("n", "<leader>gl", "<cmd>Telescope git_commits<cr>", opts)

-- Git --
keymap("n", "<leader>gw", "<cmd>Gwrite<cr>", opts)
keymap("n", "<leader>gc", "<cmd>Git commit<cr>", opts)
keymap("n", "<leader>gp", "<cmd>Git push<cr>", opts)
keymap("n", "<leader>gpu", "<cmd>Git push -u origin HEAD<cr>", opts)
keymap("n", "<leader>gpf", "<cmd>Git push --force<cr>", opts)
keymap("n", "<leader>gpn", "<cmd>Git push -o ci.skip<cr>", opts)
keymap("n", "<leader>gpp", "<cmd>Git pull<cr>", opts)
keymap(
	"n",
	"<leader>gy",
	'<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	opts
)

-- Browser --
keymap("n", "<leader>goo", ":OpenBrowserSmartSearch ", { noremap = true })
keymap("n", "<c-g>", "<Plug>(openbrowser-smart-search)", term_opts)
keymap("n", "<leader>b", "<cmd>Telescope bookmarks<cr>", term_opts)

-- Nvim-tree --
keymap("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", opts)

-- Packer --
local M = {}

-- Creates a snapshot of the current plugin repos and commits it.
M.commit_snapshot = function()
	local path = vim.fn.stdpath("config") .. "/packer-snapshot"
	require("packer").snapshot(path)
	vim.cmd(":Git add " .. path)
	vim.cmd(':Git commit -m "Updating snapshot"')
end
keymap("n", "<leader>ss", '<cmd>lua require("user.keymaps").commit_snapshot()<cr>', opts)
return M
