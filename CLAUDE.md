# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a personal Neovim configuration (targeting Neovim 0.12, Lua-based, managed by lazy.nvim). There is no build or test step — changes are "run" by launching Neovim.

## Structure & conventions

- `init.lua` — entry point. Requires core modules in a fixed order: `config.neovide`, `config.options`, `config.keymaps`, `config.lsp`, `config.lazy`, `config.autocmds`, then `utils.keymap-functions` and `utils.git`. It ends by `pcall`-requiring `config.api-keys` (git-ignored; missing is non-fatal).
- `lua/config/` — non-plugin core: `options.lua` (leader is `<space>`), `keymaps.lua` (global + LSP keymaps), `lsp.lua` (diagnostics UI, per-server `vim.lsp.config` overrides, `LspAttach` document-highlight autocmds), `autocmds.lua` (filetype detection), `neovide.lua`, `lazy.lua` (bootstrap).
- `lua/plugins/` — **one file per plugin**, each returning a lazy.nvim spec table (or a list of specs). lazy is initialized with `require('lazy').setup('plugins', opts)`, so any `.lua` file dropped in this directory is auto-loaded. This is the primary extension point.
- `lua/bazel/` — custom in-repo module (not a plugin) using Tree-sitter to resolve the Bazel target label under the cursor and run `bazel build/run/test`. Exposes `Bazel*UnderCursor` user commands via `M.setup()`.
- `lua/utils/` — small helper modules (git branch copy, terminal command yank, fidget spinner).
- `after/plugin/`, `plugin/ftplugin/` — standard Neovim runtime dirs for post-plugin and filetype-specific setup (e.g. `plugin/ftplugin/octo.lua` guards on `vim.bo.filetype`).
- `lazy-lock.json` — the plugin lockfile; committed. lazy pins `version = '*'` (stable tags) with auto-update checking enabled.

When adding a plugin, create a new file in `lua/plugins/` mirroring the existing spec style; check `keymaps.lua` and other plugin specs for keymap collisions before adding mappings.

## Tooling

Formatting and linting run inside Neovim, not from the shell:
- **Format**: `conform.nvim` (`lua/plugins/conform.lua`), bound to `<leader>af`. stylua for Lua (2-space, single quotes, 120 col — see `stylua.toml`), plus prettier/black/gofmt/shfmt/buildifier/etc. by filetype.
- **Lint**: `nvim-lint` (`lua/plugins/nvim-lint.lua`) on `BufWritePost`/`BufRead` — luacheck (config in `.luacheckrc`, only `vim` global), shellcheck, hadolint, commitlint, golangci-lint, etc.
- **LSP servers** are installed via Mason; the `ensure_installed` list lives in `lua/plugins/mason.lua`. Server-specific overrides (clangd, starpls, remark_ls) are in `lua/config/lsp.lua`.
- **Spelling**: `cspell.json` holds the project word allowlist.
- Commits follow Conventional Commits (`commitlint.config.js`, `@commitlint/config-conventional`).

To verify a change, launch `nvim` and check `:Lazy` (`<leader>hj`), `:Mason` (`<leader>hk`), `:LspInfo` (`<leader>li`), and `:checkhealth`.

## AI / CodeCompanion

`codecompanion.nvim` is configured (`lua/plugins/codecompanion.lua`) and is the actively-edited part of this repo. MCP servers are wired up via CodeCompanion's native `mcp.servers` config (not `mcphub.nvim`, which was removed after its tool-schema shape proved incompatible with this codecompanion version's `Tools.resolve()`). `codecompanion-workspace.json` is a CodeCompanion *workspace* file — it defines a system prompt and a map of this repo's key files for AI-assisted config editing; keep its `data` file list in sync when core files move.

## Deployment (ansible/)

`ansible/site.yml` installs Neovim (pinned version, currently 0.12.2) and this config onto remote hosts. `install_nvim.yml` clones this repo locally via `gh` into `ansible/.cache/nvim` (a generated snapshot — not the source of truth) and rsyncs it to `~/.config/nvim` on hosts in the `nvim_hosts` inventory group. `secrets.local.yml` and `inventory.ini` host details are git-ignored / templated.
