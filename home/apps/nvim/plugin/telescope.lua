local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

local telescope = require('telescope')
telescope.setup{
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
  },
  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
  },
}

telescope.load_extension("notify")
-- telescope.load_extension("yank_history")
telescope.load_extension("undo")
