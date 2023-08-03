vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*.py",
  callback = function()
    require("venv-selector").retrieve_from_cache()
  end,
})
