local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

copilot.setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

local status_ok_cmp, copilot_cmp = pcall(require, 'copilot_cmp')
if not status_ok_cmp then
  return
end

copilot_cmp.setup({
  formatters = {
    insert_text = require('copilot_cmp.format').remove_existing,
  },
})