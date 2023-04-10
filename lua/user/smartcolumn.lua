local status_ok, smart_column = pcall(require, 'smartcolumn')
if not status_ok then
  print('Could not load smartcolumn')
  return
end

smart_column.setup({
  custom_colorcolumn = { python = '120', lua = '120' },
  disabled_filetypes = {
    'help',
    'text',
    'markdown',
    'gitcommit',
    'octo',
    'git',
    'dockerfile',
    'yaml',
    'qf',
    'Trouble',
    'NvimTree',
  },
})
