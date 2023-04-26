" ===========================================================================
" =============================== Telescope =================================
" ===========================================================================

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  extensions = {
    coc = { theme = 'ivy' }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<C-c>"] = actions.close,
      },
    },
  }
}
require('telescope').load_extension('coc')
EOF
