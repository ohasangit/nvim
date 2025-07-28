local M = {}

-- Function to copy current git branch name to clipboard
function M.copy_branch_name()
  local branch = vim.fn.trim(vim.fn.system('git branch --show-current'))
  if vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repository or git command failed', vim.log.levels.ERROR)
    return
  end
  vim.fn.setreg('+', branch)
  vim.notify('Copied branch name to clipboard: ' .. branch, vim.log.levels.INFO)
end

return M
