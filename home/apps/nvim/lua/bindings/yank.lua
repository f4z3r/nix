-- Yank bindings
-- See also gitlinker bindings

local leader = "<leader>y"

local mappings = {
  {
    mode = "n",
    suffix = "y",
    command = function()
      require("lazy.utils").copy_to_clipboard()
    end,
    desc = "Copy to vim clipboard to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "l",
    command = function()
      require("yankcraft").filepath(true)
    end,
    desc = "Copy filepath and lines to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "f",
    command = require("yankcraft").filepath,
    desc = "Copy filepath to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "m",
    command = require("yankcraft").content,
    desc = "Copy content as markdown to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "n",
    command = function()
      local norg = require("yankcraft.fences.norg")
      require("yankcraft").content({ fence = norg })
    end,
    desc = "Copy content as norg to system clipboard",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
