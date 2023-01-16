local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  print('Cannot load nvim-dap')
  return
end

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- vim.api.nvim_create_autocmd("DapAutoComplete", {
--   command = "require('dap.ext.autocompl').attach()",
-- })

dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return 'python'
    end,
  },
}
