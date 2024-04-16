local string = require("string")

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local harpoon = require("harpoon")
local conf = require("telescope.config").values

harpoon:setup()

local leader = "<leader>h"

local function list_indexOf(list, predicate)
  for i, v in ipairs(list) do
    if predicate(v) then
      return i
    end
  end
  return -1
end

local function toggle_telescope(harpoon_files)
  local files = {}
  for i, item in ipairs(harpoon_files.items) do
    table.insert(files, i .. ". " .. item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = files,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        actions.select_default:replace(function(prompt_bufnr)
          local curr_entry = action_state.get_selected_entry()
          if not curr_entry then
            return
          end
          actions.close(prompt_bufnr)

          harpoon:list():select(curr_entry.index)
        end)

        map({ "n", "i" }, "<C-d>", function(prompt_bufnr)
          local curr_picker = action_state.get_current_picker(prompt_bufnr)
          curr_picker:delete_selection(function(selection)
            local mark_idx = list_indexOf(harpoon_files.items, function(v)
              return v.value == selection[1]
            end)
            if mark_idx == -1 then
              return
            end

            harpoon:list():removeAt(mark_idx)
          end)
        end)

        -- use default mappings
        return true
      end,
    })
    :find()
end

local mappings = {
  {
    mode = "n",
    suffix = "a",
    command = function()
      harpoon:list():append()
    end,
    desc = "Append to Harpoon list",
  },
  {
    mode = "n",
    suffix = "l",
    command = function()
      toggle_telescope(harpoon:list())
    end,
    desc = "Show Harpoon list in telescope",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

-- switch between item n with <leader>h<n>
for i = 1, 9 do
  vim.keymap.set("n", string.format("%s%d", leader, i), function()
    harpoon:list():select(i)
  end, {
    desc = string.format("Switch to item %d in Harpoon list", i),
  })
end

-- previous and next switch
vim.keymap.set("n", "[h", function()
  harpoon:list():prev()
end, {
  desc = "Jump to previous entry in Harpoon list",
})
vim.keymap.set("n", "]h", function()
  harpoon:list():next()
end, {
  desc = "Jump to next entry in Harpoon list",
})
