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
end
