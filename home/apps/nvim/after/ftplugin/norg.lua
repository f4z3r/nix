local leader = "<leader>a"

local mappings = {
  {
    mode = "n",
    suffix = "h",
    command = "<plug>(neorg.telescope.search_headings)",
    desc = "Find headings in current file",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc, noremap = true })
end

