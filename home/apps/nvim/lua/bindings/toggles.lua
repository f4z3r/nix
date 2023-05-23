-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = '<leader>t'

local function toggle_conceal()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end

local function toggle_spell()
  vim.o.spell = not vim.o.spell
end

local function toggle_wrap()
  vim.o.wrap = not vim.o.wrap
end

local mappings = {
  {
    mode = 'n',
    suffix = 'c',
    command = toggle_conceal,
    desc = 'Toggle conceal',
  },
  {
    mode = 'n',
    suffix = 's',
    command = toggle_spell,
    desc = 'Toggle spelling',
  },
  {
    mode = 'n',
    suffix = 'w',
    command = toggle_wrap,
    desc = 'Toggle wrap',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

