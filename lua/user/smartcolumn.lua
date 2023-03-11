local status_ok, smart_column = pcall(require, 'smartcolumn')
if not status_ok then
  print('Could not load smartcolumn')
  return
end

smart_column.setup({
  custom_colorcolumn = { python = '120' },
})
