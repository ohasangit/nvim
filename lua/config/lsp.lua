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

  vim.fn.sign_define('DapBreakpoint', {
    text = signs.text.DapBreakpoint or '',
    texthl = hl(signs.texthl, 'DapBreakpoint', 'DiagnosticVirtualTextWarn'),
    linehl = hl(signs.linehl, 'DapBreakpoint', nil),
    numhl = hl(signs.numhl, 'DapBreakpoint', nil),
  })

  vim.fn.sign_define('DapBreakpointCondition', {
    text = signs.text.DapBreakpointCondition or '',
    texthl = hl(signs.texthl, 'DapBreakpointCondition', 'DiagnosticVirtualTextError'),
    linehl = hl(signs.linehl, 'DapBreakpointCondition', nil),
    numhl = hl(signs.numhl, 'DapBreakpointCondition', nil),
  })

  vim.fn.sign_define('DapStopped', {
    text = signs.text.DapStopped or '',
    texthl = hl(signs.texthl, 'DapStopped', 'DiagnosticInfo'),
    linehl = hl(signs.linehl, 'DapStopped', nil),
    numhl = hl(signs.numhl, 'DapStopped', nil),
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

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--limit-results=10000',
    '--completion-style=detailed',
    '--log=verbose',

    -- Add the actual compiler paths that appear in compile_commands.json.
    -- Start broad, then tighten later.
    -- '--query-driver=/usr/bin/clang++-18,/usr/bin/clang-18,/usr/bin/g++*,/usr/bin/gcc*,/usr/bin/aarch64-linux-gnu-g++*,/usr/bin/aarch64-linux-gnu-gcc*',
  },

  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },

  root_markers = {
    '.clangd',
    'compile_commands.json',
    'compile_flags.txt',
    'WORKSPACE',
    'WORKSPACE.bazel',
    'MODULE.bazel',
    '.git',
  },
})

vim.lsp.config['remark_ls'] = {
  settings = {
    remark = {
      requireConfig = false,
    },
  },
}

-- Helper: find Bazel workspace root (WORKSPACE / WORKSPACE.bazel / MODULE.bazel)
local function find_bazel_root(startpath)
  local root = vim.fs.find(
    { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
    { upward = true, path = startpath or vim.loop.cwd(), type = 'file' }
  )[1]

  vim.notify('Bazel root: ' .. (root or 'not found'), vim.log.levels.INFO)

  if not root then
    return nil
  end

  return vim.fs.dirname(root)
end

-- vim.lsp.config("starpls", {
--   cmd = { "starpls" },
--   filetypes = { "bzl", "starlark", "bazel", "BUILD", "workspace" },
--   root_markers = {
--     { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
--     '.git',
--   },
-- })

-- vim.lsp.config['starpls'] = {
--   cmd = { 'starpls' },
--   filetypes = { 'bzl', 'starlark', 'bazel', 'BUILD', 'workspace' },
--   root_markers = {
--     { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
--     '.git',
--   },
-- }

local function bazel_workspace_root()
  local root = vim.fs.find(
    { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
    { upward = true, path = vim.loop.cwd(), type = 'file' }
  )[1]
  return root and vim.fs.dirname(root) or nil
end

local ws = bazel_workspace_root()

vim.lsp.config['starpls'] = {
  cmd = ws and { 'sh', '-c', ('cd %q && exec starpls'):format(ws) } or { 'starpls' },
  filetypes = { 'bzl', 'starlark', 'bazel' },
  root_markers = {
    { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
    '.git',
  },
}

local lsp_highlight_document_autogroup = vim.api.nvim_create_augroup('lsp_highlight_document', {})

-- Helper: safely highlight only if any client supports the method at call time
local function safe_document_highlight(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- Neovim 0.11: filter clients by method
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/documentHighlight' })
  if #clients == 0 then
    return
  end
  vim.lsp.buf.document_highlight()
end

local function safe_clear_references(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- Clearing is harmless; keep as a separate helper for symmetry
  vim.lsp.buf.clear_references()
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-custom', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = args.buf,
        callback = function()
          safe_document_highlight(args.buf)
        end,
        group = lsp_highlight_document_autogroup,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = args.buf,
        callback = function()
          safe_clear_references(args.buf)
        end,
        group = lsp_highlight_document_autogroup,
      })
    end
  end,
})

-- Clear highlight autocmds when an LSP client detaches to avoid stale callbacks
vim.api.nvim_create_autocmd('LspDetach', {
  group = lsp_highlight_document_autogroup,
  callback = function(args)
    -- Remove autocmds for this buffer from the group and clear references
    vim.api.nvim_clear_autocmds({ group = lsp_highlight_document_autogroup, buffer = args.buf })
    safe_clear_references(args.buf)
  end,
})
