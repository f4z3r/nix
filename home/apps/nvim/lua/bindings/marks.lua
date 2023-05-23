-- Mark bindings

local leader = '<leader>m'

local mappings = {
  {
    mode = 'n',
    suffix = 'm',
    command = function() require('telescope.builtin').marks() end,
    desc = 'Search marks',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

