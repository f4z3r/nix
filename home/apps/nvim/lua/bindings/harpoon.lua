-- Harpoon bindings

local leader = "<leader>h"

local mappings = {
  {
    mode = "n",
    suffix = "a",
    command = function()
      local harpoon = require("harpoon")
      -- ensure prepending re-indexes the file at the beginning of the list
      harpoon:list():remove()
      harpoon:list():prepend()
      if harpoon:list():length() > 4 then
        harpoon:list():remove_at(5)
      end
    end,
    desc = "Prepend item to harpoon list",
  },
  {
    mode = "n",
    suffix = "h",
    command = function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Show harpoon list",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

vim.keymap.set("n", "<leader>n", function()
  require("harpoon"):list():select(1)
end, { desc = "Switch to first harpoon item" })

vim.keymap.set("n", "<leader>e", function()
  require("harpoon"):list():select(2)
end, { desc = "Switch to second harpoon item" })

vim.keymap.set("n", "<leader>i", function()
  require("harpoon"):list():select(3)
end, { desc = "Switch to third harpoon item" })

vim.keymap.set("n", "<leader>o", function()
  require("harpoon"):list():select(4)
end, { desc = "Switch to fourth harpoon item" })
