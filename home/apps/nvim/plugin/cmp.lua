local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
      border = "rounded",
    },
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "c", "i" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "c", "i" }),
    ["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "c", "i" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "c", "i" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "c", "i" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    {
      name = "path",
      options = {
        trailing_slash = true,
      },
    },
    { name = 'luasnip' },
    { name = "luasnip_choice" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"
      return kind
    end,
  },
})

cmp.setup.filetype("norg", {
  sources = cmp.config.sources({
    { name = "neorg" },
    {
      name = "path",
      options = {
        trailing_slash = true,
      },
    },
    { name = 'luasnip' },
    { name = "luasnip_choice" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
    {
      name = "cmdline_history",
      options = { history_type = "/" },
    },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {
      name = "path",
      options = {
        trailing_slash = true,
      },
    },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
    {
      name = "cmdline_history",
      options = { history_type = ":" },
    },
  }),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
