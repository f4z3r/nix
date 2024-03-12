require("twilight").setup({
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#ffffff" },
    term_bg = "#000000",
    inactive = true,
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  expand = {
    "function",
    "method",
    "table",
    "if_statement",
    "for_statement",
  },
  exclude = {},
})
