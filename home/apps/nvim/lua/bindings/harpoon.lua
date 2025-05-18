-- Harpoon bindings

local leader = "<leader>h"

local mappings = {
  {
    mode = "n",
    suffix = "h",
    command = function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Show harpoon list",
  },
  {
    mode = "n",
    suffix = "c",
    command = function()
      require("harpoon"):list():clear()
    end,
    desc = "Clear harpoon list",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

for idx, key in ipairs({ "n", "e", "i", "o" }) do
  vim.keymap.set("n", "<leader>h" .. key, function()
    require("harpoon"):list():replace_at(idx)
  end, { desc = "Set item to fourth harpoon index" })

  vim.keymap.set("n", "<leader>" .. key, function()
    require("harpoon"):list():select(idx)
  end, { desc = "Switch to fourth harpoon item" })
end
