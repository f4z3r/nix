-- Movement bindings

local esc_mappings = {
  {
    mode = 'n',
    suffix = '<c-y>',
    command = '<esc>',
  },
  {
    mode = 'i',
    suffix = '<c-y>',
    command = '<esc>',
  },
  {
    mode = 'v',
    suffix = '<c-y>',
    command = '<esc>',
  },
  {
    mode = 'c',
    suffix = '<c-y>',
    command = '<esc>',
  },
  {
    mode = 't',
    suffix = '<esc>',
    command = '<c-\\><c-N>',
  },
}

for _, mapping in ipairs(esc_mappings) do
  vim.keymap.set(mapping.mode, mapping.suffix, mapping.command)
end

local mappings = {
  {
    mode = { 'n', 'v' },
    suffix = 'n',
    command = 'j',
  },
  {
    mode = { 'n', 'v' },
    suffix = 'N',
    command = 'J',
  },
  {
    mode = { 'n', 'v' },
    suffix = '<c-n>',
    command = '10j',
  },
  {
    mode = { 'n', 'v' },
    suffix = '<c-k>',
    command = '10k',
  },
  {
    mode = { 'n', 'v' },
    suffix = '<c-h>',
    command = 'zH_',
  },
  {
    mode = 'o',
    suffix = '<c-h>',
    command = '_',
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = '<c-l>',
    command = '$',
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'W',
    command = '<Plug>(CamelCaseMotion_w)',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'B',
    command = '<Plug>(CamelCaseMotion_b)',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'E',
    command = '<Plug>(CamelCaseMotion_e)',
    opts = { silent = true },
  },
  {
    mode = { 'n', 'v', 'o' },
    suffix = 'gE',
    command = '<Plug>(CamelCaseMotion_ge)',
    opts = { silent = true },
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, mapping.suffix, mapping.command, mapping.opts)
end
