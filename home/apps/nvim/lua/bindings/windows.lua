-- Window bindings

local leader = '<leader>w'

local mappings = {
  {
    mode = 'n',
    suffix = 'q',
    command = '<cmd>q<cr>',
    desc = 'Quit window',
  },
  {
    mode = 'n',
    suffix = 'v',
    command = '<cmd>vsplit<cr>',
    desc = 'Create vertical split',
  },
  {
    mode = 'n',
    suffix = 's',
    command = '<cmd>split<cr>',
    desc = 'Create horizontal split',
  },
  {
    mode = 'n',
    suffix = 'r',
    command = '<c-w>=',
    desc = 'Resize windows',
  },
  {
    mode = 'n',
    suffix = 'l',
    command = '<c-w>lzH',
    desc = 'Move to east window',
  },
  {
    mode = 'n',
    suffix = 'h',
    command = '<c-w>hzH',
    desc = 'Move to west window',
  },
  {
    mode = 'n',
    suffix = 'n',
    command = '<c-w>jzH',
    desc = 'Move to south window',
  },
  {
    mode = 'n',
    suffix = 'k',
    command = '<c-w>kzH',
    desc = 'Move to north window',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
