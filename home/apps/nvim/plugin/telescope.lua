local actions = require("telescope.actions")

local function repeat_action(action, count)
  return function(prompt_bufnr)
    for _ = 1, count do
      action(prompt_bufnr)
    end
  end
end

local telescope = require("telescope")
telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    mappings = {
      i = {
        ["<C-l>"] = actions.send_to_loclist,
        ["<C-o>"] = actions.send_selected_to_loclist,
        ["<C-t>"] = actions.toggle_selection,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-d>"] = repeat_action(actions.move_selection_next, 10),
        ["<C-u>"] = repeat_action(actions.move_selection_previous, 10),
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-l>"] = actions.send_to_loclist,
        ["<C-o>"] = actions.send_selected_to_loclist,
        ["<C-t>"] = actions.toggle_selection,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
  },
})

telescope.load_extension("notify")
-- telescope.load_extension("yank_history")
