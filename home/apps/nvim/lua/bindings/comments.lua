-- Comment bindings

local leader = "<leader>c"

local mappings = {
  {
    mode = "n",
    suffix = "c",
    command = function()
      require("neogen").generate()
    end,
    desc = "Add neogen comment",
  },
  {
    mode = "n",
    suffix = "t",
    command = function()
      require("neogen").generate({ type = "type" })
    end,
    desc = "Add neogen comment on type",
  },
  {
    mode = "n",
    suffix = "f",
    command = function()
      require("neogen").generate({ type = "func" })
    end,
    desc = "Add neogen comment on function",
  },
  {
    mode = "n",
    suffix = "F",
    command = function()
      require("neogen").generate({ type = "file" })
    end,
    desc = "Add neogen comment on file",
  },
  {
    mode = "n",
    suffix = "C",
    command = function()
      require("neogen").generate({ type = "class" })
    end,
    desc = "Add neogen comment on class",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
