-- Action bindings
--
-- These are currently defined in diagnostics.lua

local leader = '<leader>a'

local mappings = {
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
