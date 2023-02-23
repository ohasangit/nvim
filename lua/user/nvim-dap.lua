vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔵', texthl = '', linehl = '', numhl = '' })

local status_ok, python_dap = pcall(require, 'python-dap')
if not status_ok then
  return
end

python_dap.setup()
