-- Git bindings
--
-- These are currently defined in plugin/gitsigns

local leader = "<leader>g"

local mappings = {}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
