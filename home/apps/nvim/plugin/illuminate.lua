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
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "TelescopeSelection", nocombine = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "TelescopeSelection", nocombine = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "TelescopeSelection", nocombine = true })
