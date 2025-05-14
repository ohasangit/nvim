local signs = {
  text = {
    [vim.diagnostic.severity.ERROR] = '',
    [vim.diagnostic.severity.WARN] = '',
    [vim.diagnostic.severity.INFO] = '',
    [vim.diagnostic.severity.HINT] = '',
    DiagnosticSignError = '',
    DiagnosticSignWarn = '',
    DiagnosticSignHint = '',
    DiagnosticSignInfo = '',
    DapBreakpoint = '',
    DapBreakpointCondition = '',
    DapStopped = '',
  },
  linehl = {
    DapBreakpoint = 'DiagnosticVirtualTextWarn',
    DapBreakpointCondition = 'DiagnosticVirtualTextError',
    DapStopped = 'BufferAlternateHINT',
  },
  texthl = {
    DapBreakpoint = 'DiagnosticVirtualTextWarn',
    DapBreakpointCondition = 'DiagnosticVirtualTextError',
    DapStopped = 'BufferAlternateHINT',
  },
  numhl = {
    DapBreakpoint = 'DiagnosticVirtualTextWarn',
    DapBreakpointCondition = 'DiagnosticVirtualTextError',
    DapStopped = 'BufferAlternateHINT',
  },
}

local config = {
  virtual_text = false,
  signs = signs,
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

vim.lsp.config['clangd'] = {
  cmd = {
    'clangd',
    '--background-index',
    '--limit-results=10000',
    '--completion-style=detailed',
  },
}

vim.api.nvim_create_augroup("lsp_highlight_document", {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-custom', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
        group = "lsp_highlight_document",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
        group = "lsp_highlight_document"
      })
    end
  end,
})
