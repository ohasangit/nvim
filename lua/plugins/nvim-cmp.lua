return {
  'hrsh7th/nvim-cmp',
  branch = 'main',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'alexander-born/cmp-bazel',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      branch = 'master'
    },
    {
      'petertriho/cmp-git',
      config = true
    },
  },
  event = 'InsertEnter',
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip/loaders/from_vscode').lazy_load()

    local kind_icons = {
      Text = '󰦨',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = ' ',
      Field = ' ',
      Variable = '󰫧 ',
      Class = ' ',
      Interface = ' ',
      Module = '',
      Property = ' ',
      Unit = ' ',
      Value = ' ',
      Enum = '',
      Keyword = ' ',
      Snippet = '󰩫 ',
      Color = ' ',
      File = ' ',
      Reference = '',
      Folder = ' ',
      EnumMember = '',
      Constant = ' ',
      Struct = ' ',
      Event = '',
      Operator = '󱓉 ',
      TypeParameter = ' ',
      Copilot = ' ',
    }

    cmp.setup({
      performance = {
        max_view_entries = 20,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
            git = '[Git]',
            copilot = '[Copilot]',
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.complete_common_string(),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-1),
        ['<C-d>'] = cmp.mapping.scroll_docs(1),
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-l>'] = cmp.mapping(function()
          luasnip.jump(1)
        end, {
          'i',
          's',
        }),
        ['<C-h>'] = cmp.mapping(function()
          luasnip.jump(-1)
        end, {
          'i',
          's',
        }),
      },
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp_signature_help' },
          { name = 'copilot' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'bazel' },
          { name = 'path' },
          { name = 'luasnip' },
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
            entry_filter = function(entry, _)
              return #entry.completion_item.label <= 150
            end,
          },
        }),
    })

    cmp.setup.cmdline('/', {
      mapping = {
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.complete_common_string(), { 'c' }),
        ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'c' }),
      },
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = {
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.complete_common_string(), { 'c' }),
        ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'c' }),
      },
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
      }, {
        { name = 'git' }
      }, {
        { name = 'buffer' }
      })
    })

    cmp.setup.filetype('octo', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
