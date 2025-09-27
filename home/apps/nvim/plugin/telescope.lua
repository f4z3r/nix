local actions = require("telescope.actions")

local function repeat_action(action, count)
  return function(prompt_bufnr)
    for _ = 1, count do
      action(prompt_bufnr)
    end
  end
end

local function flash(prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

local telescope = require("telescope")
telescope.setup({
  defaults = {
    layout_strategy = "vertical",
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
        ["<c-j>"] = flash,
      },
      n = {
        ["<C-l>"] = actions.send_to_loclist,
        ["<C-o>"] = actions.send_selected_to_loclist,
        ["<C-t>"] = actions.toggle_selection,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,
        j = flash,
      },
    },
  },
  extensions = {},
})

telescope.load_extension("notify")
-- telescope.load_extension("yank_history")
