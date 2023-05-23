local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-c>"] = actions.close,
        ["<C-y>"] = actions.close,
        ["<esc>"] = actions.close,
      },
    },
  }
}
