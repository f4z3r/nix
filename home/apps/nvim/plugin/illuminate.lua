require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
  },
  delay = 100,
  filetype_overrides = {},
  filetypes_denylist = {
    "alpha",
  },
  filetypes_allowlist = {},
  under_cursor = true,
  min_count_to_highlight = 2,
})
