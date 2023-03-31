local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

local mason_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_status_ok then
  return
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
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

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>af', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

local on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

mason_lspconfig.setup({
  ensure_installed = { 'lua_ls' },
})

local util = require('lspconfig/util')

local path = util.path

local function extract_virtualenv_path(str)
  local pattern = "%S*virtualenv%S*"
  local match = string.match(str, pattern)
  if match then
    return string.match(match, "%S+")
  end
end

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    venv = extract_virtualenv_path(venv)
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      on_attach = on_attach,
    })
  end,
  ['lua_ls'] = function()
    require('lspconfig').lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
  ['pyright'] = function()
    require('lspconfig').pyright.setup({
      on_attach = on_attach,
      on_init = function(client)
        local python_path = get_python_path(client.config.root_dir)
        print(python_path)
        client.config.settings.python.pythonPath = python_path
      end,
      settings = {
        python = {
          -- venvPath = '/home/ohasan/.local/share/virtualenvs/atmc-cloud-nXf4VJD4/',
          -- pythonPath = '/usr/bin/python3',
          analysis = {
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportMissingTypeStubs = 'information',
              reportImportCycles = 'information',
              reportDeprecated = 'information',
            },
          },
        },
      },
    })
  end,
  ['yamlls'] = function()
    require('lspconfig').yamlls.setup({
      on_attach = on_attach,
      settings = {
        yaml = {
          keyOrdering = false,
        }
      },
    })

  end
})

local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
  return
end

-- require('mason-nvim-dap').setup()
-- require('mason-nvim-dap').setup_handlers({
--   function(source_name)
--     -- all sources with no handler get passed here

--     -- Keep original functionality of `automatic_setup = true`
--     require('mason-nvim-dap.automatic_setup')(source_name)
--   end,
--   python = function(source_name)
--     dap.adapters.python = {
--       type = 'executable',
--       command = 'python',
--       args = {
--         '-m',
--         'debugpy.adapter',
--       },
--       -- options: {
--       --   env {
--       --     ['PYTHONPATH'] = '/usr/local/lib/python3.9/site-packages',
--       --   },
--       -- },
--     }

--     dap.configurations.python = {
--       {
--         type = 'python',
--         request = 'launch',
--         name = 'Launch file',
--         program = '${file}',
--         pythonPath = 'python',
--         -- pythonPath = function()
--         --   local cwd = vim.fn.getcwd()
--         --   local venv = cwd .. '/.venv/bin/python'
--         --   if vim.fn.executable(venv) == 1 then
--         --     return venv
--         --   end
--         --   return 'python'
--         -- end,
--       },
--     }
--   end,
-- })
