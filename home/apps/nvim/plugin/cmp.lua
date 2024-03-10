local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "c", "i"}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "c", "i"}),
    ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { "c", "i"}),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { "c", "i"}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { "c", "i"}),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<tab>'] = cmp.mapping.confirm({select = true}),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    {
      name = 'path',
      options = {
        trailing_slash = true,
      },
    },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('org', {
  sources = cmp.config.sources({
    { name = 'orgmode' },
    {
      name = 'path',
      options = {
        trailing_slash = true,
      },
    },
  }, {
    { name = 'buffer' },
  }),
})


cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
