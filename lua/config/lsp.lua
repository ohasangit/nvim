local M = {}

M.init = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  vim.fn.sign_define('DapBreakpoint',
    {
      text = '',
      texthl = 'DiagnosticVirtualTextWarn',
      linehl = 'DiagnosticVirtualTextWarn',
      numhl = 'DiagnosticVirtualTextWarn'
    })
  vim.fn.sign_define('DapBreakpointCondition',
    {
      text = '',
      texthl = 'DiagnosticVirtualTextError',
      linehl = 'DiagnosticVirtualTextError',
      numhl = 'DiagnosticVirtualTextError'
    })
  vim.fn.sign_define('DapStopped',
    { text = '', texthl = 'BufferAlternateHINT', linehl = 'BufferAlternateHINT', numhl = 'BufferAlternateHINT' })

  local config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)
end

M.on_attach = function(client, bufnr)
  M.lsp_keymaps(bufnr)
  M.lsp_highlight_document(client, bufnr)
end

M.lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.lsp_highlight_document = function(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    -- vim.api.nvim_create_augroup("lsp_highlight_document")
    -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_highlight_document" })
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   buffer = 0,
    --   callback = vim.lsp.buf.document_highlight(),
    --   group = "lsp_highlight_document",
    -- })
    -- vim.api.nvim_create_autocmd("CursorMoved", {
    --   buffer = 0,
    --   callback = vim.lsp.buf.clear_references(),
    --   group = "lsp_highlight_document"
    -- })


    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

return M
