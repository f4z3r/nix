local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local function add_to_arglist(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager

  vim.cmd("%argd")
  for item in manager:iter() do
    vim.cmd("argadd " .. item.filename)
  end
  actions.close(prompt_bufnr)
end

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
    mappings = {
      i = {
        ["<C-l>"] = add_to_arglist,
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-d>"] = repeat_action(actions.move_selection_next, 10),
        ["<C-u>"] = repeat_action(actions.move_selection_previous, 10),
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-l>"] = add_to_arglist,
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-c>"] = actions.close,
        ["<C-y>"] = actions.close,
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
  },
})

telescope.load_extension("notify")
telescope.load_extension("git_worktree")
-- telescope.load_extension("yank_history")
