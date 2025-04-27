-- Mark bindings

local leader = "<leader>m"

local mappings = {
  {
    mode = "n",
    suffix = "m",
    command = function()
      require("telescope").extensions.markit.marks_list_buf({ path_display = "shorten" })
    end,
    desc = "Search buffer marks",
  },
  {
    mode = "n",
    suffix = "p",
    command = function()
      require("markit").preview()
    end,
    desc = "Preview marks",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

vim.keymap.set("n", "0", require("markit").toggle_bookmark0, { desc = "Toggle JUMP bookmark" })
