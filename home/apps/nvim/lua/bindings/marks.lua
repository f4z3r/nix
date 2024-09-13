-- Mark bindings

local leader = "<leader>m"

local mappings = {
  {
    mode = "n",
    suffix = "m",
    command = function()
      require("telescope").extensions.marks_nvim.marks_list_buf({ path_display = "shorten" })
    end,
    desc = "Search buffer marks",
  },
  {
    mode = "n",
    suffix = "a",
    command = function()
      require("telescope").extensions.marks_nvim.marks_list_all({ path_display = "shorten" })
    end,
    desc = "Search all marks",
  },
  {
    mode = "n",
    suffix = "b",
    command = function()
      require("telescope").extensions.marks_nvim.bookmarks_list_all({ path_display = "shorten" })
    end,
    desc = "Search all bookmarks",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
