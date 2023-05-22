local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
    },
  }
}
