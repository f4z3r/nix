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
      vim.cmd("normal! \27")
    end,
    desc = "Copy filepath and lines to system clipboard",
  },
  {
    mode = "n",
    suffix = "f",
    command = function()
      require("yankcraft").filepath()
    end,
    desc = "Copy filepath to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "m",
    command = function()
      require("yankcraft").content()
      vim.cmd("normal! \27")
    end,
    desc = "Copy content as markdown to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "n",
    command = function()
      local norg = require("yankcraft.formatters.norg")
      require("yankcraft").content({ formatter = norg })
      vim.cmd("normal! \27")
    end,
    desc = "Copy content as norg to system clipboard",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
