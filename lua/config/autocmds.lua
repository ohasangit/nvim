vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*.py",
  callback = function()
    require("venv-selector").retrieve_from_cache()
  end,
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Jenkinsfile" },
  group = vim.api.nvim_create_augroup("filetypedetect", { clear = false }),
  command = "set filetype=groovy",
})
