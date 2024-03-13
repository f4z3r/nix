local leader = "<leader>a"

local mappings = {
  {
    mode = "n",
    suffix = "tf",
    command = function()
      require("tablemd").format()
    end,
    desc = "Format table under cursor",
  },
  {
    mode = "n",
    suffix = "td",
    command = function()
      require("tablemd").deleteColumn()
    end,
    desc = "Delete table column under cursor",
  },
  {
    mode = "n",
    suffix = "tc",
    command = function()
      require("tablemd").insertColumn(false)
    end,
    desc = "Add table column to the right",
  },
  {
    mode = "n",
    suffix = "tr",
    command = function()
      require("tablemd").insertRow(false)
    end,
    desc = "Add table row below",
  },
  {
    mode = "n",
    suffix = "tR",
    command = function()
      require("tablemd").insertRow(true)
    end,
    desc = "Add table row above",
  },
  {
    mode = "n",
    suffix = "th",
    command = function()
      require("tablemd").alignColumn("left")
    end,
    desc = "Left justify column",
  },
  {
    mode = "n",
    suffix = "tl",
    command = function()
      require("tablemd").alignColumn("right")
    end,
    desc = "Right justify column",
  },
  {
    mode = "n",
    suffix = "tk",
    command = function()
      require("tablemd").alignColumn("center")
    end,
    desc = "Center justify column",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc, noremap = true })
end
