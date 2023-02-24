vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticVirtualTextWarn', linehl = 'DiagnosticVirtualTextWarn', numhl = 'DiagnosticVirtualTextWarn' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticVirtualTextError', linehl = 'DiagnosticVirtualTextError', numhl = 'DiagnosticVirtualTextError' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'BufferAlternateHINT', linehl = 'BufferAlternateHINT', numhl = 'BufferAlternateHINT' })

local status_ok, python_dap = pcall(require, 'dap-python')
if not status_ok then
  print('cant load dap-python')
  return
end

python_dap.setup()

local status_ok_vt, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not status_ok_vt then
  print('cant load nvim-dap-virtual-text')
  return
end

dap_virtual_text.setup({
  virt_text_win_col = 80,
})
