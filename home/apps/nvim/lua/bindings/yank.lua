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
      local formatter = require("yankcraft.formatters.filepath_with_line_range")
      require("yankcraft").copy({ formatter = formatter })
      vim.cmd("normal! \27")
    end,
    desc = "Copy filepath and lines to system clipboard",
  },
  {
    mode = "n",
    suffix = "f",
    command = function()
      local formatter = require("yankcraft.formatters.filepath")
      require("yankcraft").copy({ formatter = formatter })
      vim.cmd("normal! \27")
    end,
    desc = "Copy filepath to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "m",
    command = function()
      local formatter = require("yankcraft.formatters.markdown")
      require("yankcraft").copy({ formatter = formatter })
      vim.cmd("normal! \27")
    end,
    desc = "Copy content as Markdown to system clipboard",
  },
  {
    mode = { "n", "x" },
    suffix = "n",
    command = function()
      local formatter = require("yankcraft.formatters.norg")
      require("yankcraft").copy({ formatter = formatter })
      vim.cmd("normal! \27")
    end,
    desc = "Copy content as Norg to system clipboard",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
