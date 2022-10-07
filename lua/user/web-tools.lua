local status_ok, web_tools = pcall(require, "web-tools")
if not status_ok then
  print("Could not load web-tools")
  return
end

web_tools.setup({
  keymaps = {
    rename = nil, -- by default use same setup of lspconfig
    repeat_rename = '.', -- . to repeat
  },
})
