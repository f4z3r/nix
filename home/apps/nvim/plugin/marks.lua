require("marks").setup({
  default_mappings = false,
  builtin_marks = {},
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = {
    lower = 10,
    upper = 0,
    builtin = 8,
    bookmark = 0,
  },
  excluded_filetypes = {},
  excluded_buftypes = {},
  mappings = {
    set_next = "mm",
    next = "]]",
    prev = "[[",
    delete_line = "dm",
  },
})
