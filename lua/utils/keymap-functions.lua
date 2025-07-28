local M = {}

function M.yank_current_command()
  local line = vim.api.nvim_get_current_line()
  -- Extract the command part by removing everything before the last $
  local command = string.match(line, '.-%$%s*(.*)')
  vim.fn.setreg('+', command)
end

return M
