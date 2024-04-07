-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = "<leader>n"

local mappings = {
  {
    mode = "n",
    suffix = "i",
    command = "<cmd>Neorg workspace notes<cr>",
    desc = "Open neorg inbox",
  },
  {
    mode = "n",
    suffix = "n",
    command = "<cmd>Neorg journal today<cr>",
    desc = "Open journal today",
  },
  {
    mode = "n",
    suffix = "y",
    command = "<cmd>Neorg journal yesterday<cr>",
    desc = "Open journal for yesterday",
  },
  {
    mode = "n",
    suffix = "t",
    command = "<cmd>Neorg journal tomorrow<cr>",
    desc = "Open journal for tomorrow",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

