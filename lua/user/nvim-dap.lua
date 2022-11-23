local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  print('Cannot load nvim-dap')
  return
end

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
