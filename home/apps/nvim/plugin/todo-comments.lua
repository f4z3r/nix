require("todo-comments").setup({
  highlight = {
    multiline = false,
    pattern = [[.*<(KEYWORDS).*:]],
  },
  search = {
    pattern = "\\b(KEYWORDS)[:\\(]",
  },
})
