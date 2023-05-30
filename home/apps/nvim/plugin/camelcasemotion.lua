-- CamelCase movement bindings

local mappings = {
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'W',
    command = '<Plug>CamelCaseMotion_w',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'B',
    command = '<Plug>CamelCaseMotion_b',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'E',
    command = '<Plug>CamelCaseMotion_e',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'gE',
    command = '<Plug>CamelCaseMotion_ge',
    opts = { silent = true },
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, mapping.suffix, mapping.command, mapping.opts)
end
