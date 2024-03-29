-- Orgmode bindings

local leader = "<leader>o"

local mappings = {
  {
    mode = "n",
    suffix = "s",
    command = "<cmd>Telescope orgmode search_headings<cr>",
    desc = "Search orgmode headings",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
