local status_ok, dapui = pcall(require, 'dapui')
if not status_ok then
  print('cant load dapui')
  return
end

dapui.setup()

local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
