local status_ok, trouble_config = pcall(require, 'trouble')
if not status_ok then
  print('trouble not installed')
  return
end

trouble_config.setup({
  position = 'right',
  height = 20,
  use_diagnostic_signs = true,
})
