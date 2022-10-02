local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    }
  }
}

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

mason_lspconfig.setup {
  ensure_installed = { "sumneko_lua" },
  -- automatic_installation = false,
}

-- Apparently below is how you do automatic setup of all servers... however they aren't getting attached to
-- buffers, so not sure what's going on.

mason_lspconfig.setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["sumneko_lua"] = function ()
    require"lspconfig".sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
})
