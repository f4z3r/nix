local lspkind = require("lspkind")

local opts = {
  outline_window = {
    position = 'right',
    split_command = nil,
    width = 25,
    relative_width = true,
    auto_close = false,
    auto_jump = false,
    jump_highlight_duration = 300,
    center_on_jump = true,
    show_numbers = false,
    show_relative_numbers = false,
    wrap = false,

    show_cursorline = true,
    hide_cursor = false,
    focus_on_open = true,
    winhl = '',
    no_provider_message = 'No supported provider...'
  },

  outline_items = {
    show_symbol_details = true,
    show_symbol_lineno = true,
    highlight_hovered_item = true,
    auto_set_cursor = true,
    auto_update_events = {
      follow = { 'CursorMoved' },
      items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
    },
  },

  -- Options for outline guides which help show tree hierarchy of symbols
  guides = {
    enabled = true,
    markers = {
      bottom = '└',
      middle = '├',
      vertical = '│',
    },
  },

  symbol_folding = {
    autofold_depth = 1,
    auto_unfold = {
      hovered = true,
      only = true,
    },
    markers = { '', '' },
  },

  preview_window = {
    auto_preview = false,
    open_hover_on_preview = false,
    width = 50,     -- Percentage or integer of columns
    min_width = 50, -- Minimum number of columns
    relative_width = true,
    height = 50,     -- Percentage or integer of lines
    min_height = 10, -- Minimum number of lines
    relative_height = true,
    border = 'single',
    winhl = 'NormalFloat:',
    winblend = 0,
    live = false
  },

  keymaps = {
    show_help = '?',
    close = {'<Esc>', 'q'},
    goto_location = {},
    peek_location = 'o',
    goto_and_close = '<cr>',
    restore_location = '<C-g>',
    hover_symbol = '<S-space>',
    toggle_preview = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
    fold = 'h',
    unfold = 'l',
    fold_toggle = '<Tab>',
    fold_toggle_all = '<S-Tab>',
    fold_all = 'W',
    unfold_all = 'E',
    fold_reset = 'R',
    down_and_jump = {},
    up_and_jump = {},
  },

  providers = {
    priority = { 'lsp', 'markdown', 'norg', 'man' },
    lsp = {
      blacklist_clients = {},
    },
    markdown = {
      filetypes = {'markdown'},
    },
  },

  symbols = {
    filter = nil,

    -- You can use a custom function that returns the icon for each symbol kind.
    -- This function takes a kind (string) as parameter and should return an
    -- icon as string.
    ---@param kind string Key of the icons table below
    ---@param bufnr integer Code buffer
    ---@param symbol outline.Symbol The current symbol object
    ---@return string|boolean The icon string to display, such as "f", or `false`
    ---                       to fallback to `icon_source`.
    icon_fetcher = function(kind)
      -- XXX: f4z3r on 2026-01-27 - this is a workaround because the icon_source "lspkind" causes an error
      -- See: https://github.com/onsails/lspkind.nvim/commit/eef4764679f691ead2d38ca82f16e9c2aa5f29f8
      -- When commit present in setup, remove this workaround.
      return lspkind.symbol_map[kind] or ""
    end,
    -- 3rd party source for fetching icons. This is used as a fallback if
    -- icon_fetcher returned an empty string.
    -- Currently supported values: 'lspkind'
    icon_source = "",
    -- The next fallback if both icon_fetcher and icon_source has failed, is
    -- the custom mapping of icons specified below. The icons table is also
    -- needed for specifying hl group.
    icons = {
      File = { icon = '󰈔', hl = 'Identifier' },
      Module = { icon = '󰆧', hl = 'Include' },
      Namespace = { icon = '󰅪', hl = 'Include' },
      Package = { icon = '󰏗', hl = 'Include' },
      Class = { icon = '𝓒', hl = 'Type' },
      Method = { icon = 'ƒ', hl = 'Function' },
      Property = { icon = '', hl = 'Identifier' },
      Field = { icon = '󰆨', hl = 'Identifier' },
      Constructor = { icon = '', hl = 'Special' },
      Enum = { icon = 'ℰ', hl = 'Type' },
      Interface = { icon = '󰜰', hl = 'Type' },
      Function = { icon = '', hl = 'Function' },
      Variable = { icon = '', hl = 'Constant' },
      Constant = { icon = '', hl = 'Constant' },
      String = { icon = '𝓐', hl = 'String' },
      Number = { icon = '#', hl = 'Number' },
      Boolean = { icon = '⊨', hl = 'Boolean' },
      Array = { icon = '󰅪', hl = 'Constant' },
      Object = { icon = '⦿', hl = 'Type' },
      Key = { icon = '', hl = 'Type' },
      Null = { icon = '󰟢', hl = 'Type' },
      EnumMember = { icon = '', hl = 'Identifier' },
      Struct = { icon = '𝓢', hl = 'Structure' },
      Event = { icon = '🗲', hl = 'Type' },
      Operator = { icon = '+', hl = 'Identifier' },
      TypeParameter = { icon = '𝙏', hl = 'Identifier' },
      Component = { icon = '󰅴', hl = 'Function' },
      Fragment = { icon = '󰅴', hl = 'Constant' },
      TypeAlias = { icon = ' ', hl = 'Type' },
      Parameter = { icon = ' ', hl = 'Identifier' },
      StaticMethod = { icon = ' ', hl = 'Function' },
      Macro = { icon = ' ', hl = 'Function' },
    },
  },
}
require("outline").setup(opts)
