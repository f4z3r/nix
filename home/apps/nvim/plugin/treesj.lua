local treesj = require("treesj")

treesj.setup({
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 120,
  cursor_behavior = 'hold',
  notify = true,
  dot_repeat = true,
  on_error = nil,
})
