-- Harpoon bindings

local string = require("string")

local harpoon = require("harpoon")

harpoon:setup()

local leader = "<leader>h"

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
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
    desc = "Append to Harpoon list",
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
