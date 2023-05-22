-- Jumplist bindings

local leader = '<leader>j'

local mappings = {
  {
    mode = 'n',
    suffix = 'j',
    command = function() require('telescope.builtin').jumplist() end,
    desc = 'Search jumplist',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
