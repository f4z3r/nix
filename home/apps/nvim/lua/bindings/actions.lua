-- Action bindings
--
-- These are currently defined in diagnostics.lua
-- For markdown table formatting, see after/ftplugin/markdown.lua

local leader = "<leader>a"

local mappings = {
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
