local status_ok, chatgpt = pcall(require, 'chatgpt')
if not status_ok then
  print('chatgpt not installed')
  return
end

chatgpt.setup({
  popup_input = {
    submit = '<C-h>',
  }
})
