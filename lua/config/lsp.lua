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
end

M.select_formatter = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

  local formatting_clients = {}
  for _, client in pairs(clients) do
    if client.server_capabilities.documentFormattingProvider then
      table.insert(formatting_clients, client.name)
    end
  end

  if #formatting_clients == 0 then
    print('No clients available for formatting')
    return
  end

  if #formatting_clients == 1 then
    vim.lsp.buf.format({ async = true })
    return
  end

  print('Select a formatter:')
  for i, client_name in ipairs(formatting_clients) do
    print(i .. ". " .. client_name)
  end
  local choice = tonumber(vim.fn.input("Formatter number: "))
  local selected_client = formatting_clients[choice]

  if not selected_client then
    print("Invalid selection")
    return
  end

  print("\nSelected: " .. selected_client)

  vim.lsp.buf.format({ async = true, filter = function(client) return client.name == selected_client end })
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
