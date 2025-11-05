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

do
  local function hl(tbl, key, fallback)
    return (tbl and tbl[key]) or fallback
  end

  vim.fn.sign_define("DapBreakpoint", {
    text   = signs.text.DapBreakpoint or "",
    texthl = hl(signs.texthl, "DapBreakpoint", "DiagnosticVirtualTextWarn"),
    linehl = hl(signs.linehl, "DapBreakpoint", nil),
    numhl  = hl(signs.numhl, "DapBreakpoint", nil),
  })

  vim.fn.sign_define("DapBreakpointCondition", {
    text   = signs.text.DapBreakpointCondition or "",
    texthl = hl(signs.texthl, "DapBreakpointCondition", "DiagnosticVirtualTextError"),
    linehl = hl(signs.linehl, "DapBreakpointCondition", nil),
    numhl  = hl(signs.numhl, "DapBreakpointCondition", nil),
  })

  vim.fn.sign_define("DapStopped", {
    text   = signs.text.DapStopped or "",
    texthl = hl(signs.texthl, "DapStopped", "DiagnosticInfo"),
    linehl = hl(signs.linehl, "DapStopped", nil),
    numhl  = hl(signs.numhl, "DapStopped", nil),
  })
end

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

vim.lsp.config['remark_ls'] = {
  settings = {
    remark = {
      requireConfig = false,
    },
  },
}

local lsp_highlight_document_autogroup = vim.api.nvim_create_augroup('lsp_highlight_document', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-custom', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
        group = lsp_highlight_document_autogroup
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
        group = lsp_highlight_document_autogroup
      })
    end
  end,
})
