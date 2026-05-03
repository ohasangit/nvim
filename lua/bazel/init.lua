local M = {}

local ts = vim.treesitter

local function escape_pattern(s)
  return s:gsub('([^%w])', '%%%1')
end

local function current_bazel_label(name)
  local ws = vim.fn.systemlist('bazel info workspace')[1] or ''
  ws = ws:gsub('%s+$', '')
  if ws == '' then
    return nil, 'Not in a Bazel workspace'
  end

  local file = vim.fn.expand('%:p')
  local pkg = vim.fn.fnamemodify(file, ':h')
  pkg = pkg:gsub('^' .. escape_pattern(ws) .. '/', '')

  if pkg == '' then
    return '//:' .. name
  else
    return '//' .. pkg .. ':' .. name
  end
end

function M.get_target_under_cursor()
  local target = vim.fn.expand('<cword>')
  if target == '' then
    return nil
  end
  return target
end

---@return TSNode|nil
function M.get_node_at_cursor()
  local bufnr = 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local lang = ts.language.get_lang(vim.bo[bufnr].filetype)
  if not lang then
    return nil
  end

  local parser = ts.get_parser(bufnr, lang)
  if not parser then
    return nil
  end
  local tree = parser:parse()[1]
  if not tree then
    return nil
  end
  local root = tree:root()
  return root:named_descendant_for_range(row, col, row, col)
end

--- @param node TSNode|nil
function M.ascend_to_call(node)
  while node do
    local type = node:type()
    local name = ts.get_node_text(node, 0)
    -- vim.notify('Node type: ' .. type .. ', name: ' .. name)
    if type == 'call' or type == 'call_expression' then
      return node
    end
    node = node:parent()
    -- vim.notify('Ascended to parent node: ' .. (node and node:type() or 'nil'))
  end
  return nil
end

function M.get_keyword_string_arg(call_node, key, bufnr)
  local args = call_node:field('arguments')[1]
  if not args then
    return nil
  end

  for child in args:iter_children() do
    if child:type() == 'keyword_argument' then
      local name_node = child:field('name')[1]
      if name_node then
        local name_text = ts.get_node_text(name_node, bufnr)
        if name_text == key then
          local value_node = child:field('value')[1]
          if value_node then
            local text = ts.get_node_text(value_node, bufnr)
            -- Strip quotes if it's a "string" node like `"mock_system"`
            text = text:gsub('^"', ''):gsub('"$', '')
            return text
          end
        end
      end
    end
  end

  return nil
end

---@return string
function M.current_bazel_label()
  local bazel_workspace = vim.fn.system('bazel info workspace') or ''
  if bazel_workspace == '' then
    return ''
  end
  return bazel_workspace
end

function M.run_target_under_cursor()
  local target = vim.fn.expand('<cword>')
  if target == '' then
    vim.notify('No target under cursor', vim.log.levels.WARN)
    return
  end
  local cmd = { 'bazel', 'build', target }
  -- vim.notify('Running: ' .. table.concat(cmd, ' '))
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line ~= '' then
          vim.schedule(function()
            -- vim.notify(line)
          end)
        end
      end
    end,
    on_stderr = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line ~= '' then
          vim.schedule(function()
            vim.notify(line, vim.log.levels.ERROR)
          end)
        end
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        vim.notify('Bazel build exited with code ' .. code)
      end)
    end,
  })
end

local function get_bazel_target_under_cursor()
  local bufnr = 0
  local node = M.get_node_at_cursor()
  if not node then
    return nil, 'No Tree-sitter node under cursor'
  end

  local call = M.ascend_to_call(node)
  if not call then
    return nil, 'Cursor is not inside a Bazel/Starlark call'
  end

  local name = M.get_keyword_string_arg(call, 'name', bufnr)
  if not name then
    return nil, 'No name="..." keyword in this rule'
  end

  local label, err = current_bazel_label(name)
  if not label then
    return nil, err
  end

  return label, nil
end

function M.run_bazel_here(kind)
  kind = kind or 'build'
  local label, err = get_bazel_target_under_cursor()
  if not label then
    vim.notify(err, vim.log.levels.WARN)
    return
  end

  local cmd = ('bazel %s %s'):format(kind, label)
  -- vim.notify('Running: ' .. cmd, vim.log.levels.DEBUG)
  vim.cmd('split | terminal ' .. cmd)
end

function M.setup()
  vim.api.nvim_create_user_command('BazelWorkspace', function()
    local workspace_label = M.current_bazel_label()
    -- vim.notify(workspace_label)
  end, {})
  vim.api.nvim_create_user_command('BazelNodeUnderCursor', function()
    local node = M.get_node_at_cursor()

    if node then
      local text = ts.get_node_text(node, 0)
      -- vim.notify('Node under cursor: ' .. text)
    else
      vim.notify('No node under cursor', vim.log.levels.WARN)
    end
  end, {})
  vim.api.nvim_create_user_command('BazelGetCallNodeUnderCursor', function()
    local node = M.get_node_at_cursor()
    local call_node = M.ascend_to_call(node)
    if not call_node then
      vim.notify('No call node under cursor', vim.log.levels.WARN)
      return
    end
    -- return vim.notify('Call node under cursor: ' .. ts.get_node_text(call_node, 0))
  end, {})
  vim.api.nvim_create_user_command('BazelGetTargetNameUnderCursor', function()
    local node = M.get_node_at_cursor()
    local call_node = M.ascend_to_call(node)
    if not call_node then
      vim.notify('No call node under cursor', vim.log.levels.WARN)
      return
    end
    local target_name = M.get_keyword_string_arg(call_node, 'name', 0)
    if target_name then
      vim.fn.setreg('+', target_name)
      vim.notify('Copied target name to clipboard: ' .. target_name, vim.log.levels.INFO)
    else
      vim.notify('No target name found in call node', vim.log.levels.WARN)
    end
  end, {})
  vim.api.nvim_create_user_command('BazelGetTargetLabelUnderCursor', function()
    local label, err = get_bazel_target_under_cursor()
    if label then
      vim.fn.setreg('+', label)
      -- vim.notify('Bazel target label: ' .. label)
    else
      vim.notify('Error: ' .. err, vim.log.levels.ERROR)
    end
  end, {})
  vim.api.nvim_create_user_command('BazelBuildUnderCursor', function()
    M.run_bazel_here('build')
  end, {})
  vim.api.nvim_create_user_command('BazelRunUnderCursor', function()
    M.run_bazel_here('run')
  end, {})
  vim.api.nvim_create_user_command('BazelTestUnderCursor', function()
    M.run_bazel_here('test')
  end, {})
end

return M
