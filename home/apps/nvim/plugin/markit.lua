require("marks").setup({
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = {},
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "0",
    virt_text = "JUMP",
    annotate = false,
  },
  bookmark_1 = {
    sign = "1",
    virt_text = "",
    annotate = false,
  },
  bookmark_2 = {
    sign = "2",
    virt_text = "",
    annotate = false,
  },
  bookmark_3 = {
    sign = "3",
    virt_text = "",
    annotate = false,
  },
  bookmark_4 = {
    sign = "4",
    virt_text = "",
    annotate = false,
  },
  bookmark_5 = {
    sign = "5",
    virt_text = "TODO",
    annotate = false,
  },
  bookmark_6 = {
    sign = "6",
    virt_text = "",
    annotate = false,
  },
  bookmark_7 = {
    sign = "7",
    virt_text = "",
    annotate = false,
  },
  bookmark_8 = {
    sign = "8",
    virt_text = "",
    annotate = false,
  },
  bookmark_9 = {
    sign = "9",
    virt_text = "",
    annotate = false,
  },
  mappings = {
    set = "M",
    toggle_mark = "m",
  },
})
