local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")

harpoon:setup({
  mylist = {
    display = function(item)
      local root = vim.loop.cwd()
      return item.value:gsub("^" .. root, "")
    end,
  }
})

harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
