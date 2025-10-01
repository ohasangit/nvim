if vim.g.neovide then
  vim.o.guifont = "UbuntuMono Nerd Font:h13"
  vim.g.neovide_opacity = 0.85
  vim.g.neovide_refresh_rate = 100
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_profiler = false
  vim.g.neovide_scroll_animation_far_lines = 0

  local home_dir = vim.fn.getenv('HOME')
  local path = vim.fn.getenv('PATH')

  vim.fn.setenv("GOPATH", home_dir .. "/go")
  vim.fn.setenv("PATH",
    path ..
    ":/usr/local/go/bin:" ..
    home_dir .. "/.local/bin:" .. home_dir .. "/go/bin:" .. home_dir .. "/.tfenv/bin:" .. home_dir .. "/.cargo/bin")
  vim.fn.setenv("PYENV_ROOT", home_dir .. "/.pyenv")

  -- Prefer Node.js from nvm (needed for Copilot / LLM plugins needing Node >= 22)
  -- This handles GUI startup where shell init files are not sourced.
  local nvm_dir = home_dir .. '/.nvm'
  if vim.fn.isdirectory(nvm_dir) == 1 then
    local node_bin = nil
    -- Try explicit default alias first (fast path)
    local default_alias_path = nvm_dir .. '/alias/default'
    local f = io.open(default_alias_path, 'r')
    if f then
      local default_version = f:read('*l')
      f:close()
      if default_version and default_version ~= '' then
        local candidate = nvm_dir .. '/versions/node/' .. default_version .. '/bin'
        if vim.fn.isdirectory(candidate) == 1 then
          node_bin = candidate
        end
      end
    end
    -- Fallback: grab the newest v22.* directory if alias missing
    if not node_bin then
      local matches = vim.fn.glob(nvm_dir .. '/versions/node/v22.*', 0, 1)
      if type(matches) == 'table' and #matches > 0 then
        table.sort(matches)
        node_bin = matches[#matches] .. '/bin'
      end
    end
    -- Prepend so it takes precedence over any system Node (avoid duplicates)
    if node_bin and not string.find(vim.fn.getenv('PATH') or '', node_bin, 1, true) then
      vim.fn.setenv('PATH', node_bin .. ':' .. vim.fn.getenv('PATH'))
    end
  end
end
