-- Search bindings

local leader = '<leader>/'

local mappings = {
  {
    mode = 'n',
    suffix = 'T',
    command = function() require('telescope.builtin').tags() end,
    desc = 'Search all tags',
  },
  {
    mode = 'n',
    suffix = 's',
    command = function() require('telescope.builtin').treesitter() end,
    desc = 'Search all tags (treesitter)',
  },
  {
    mode = 'n',
    suffix = 't',
    command = function() require('telescope.builtin').current_buffer_tags() end,
    desc = 'Search current buffer tags',
  },
  {
    mode = 'n',
    suffix = 'g',
    command = function() require('telescope.builtin').git_commits() end,
    desc = 'Search git commits',
  },
  {
    mode = 'n',
    suffix = 'c',
    command = function() require('telescope.builtin').commands() end,
    desc = 'Search commands',
  },
  {
    mode = 'n',
    suffix = 'k',
    command = function() require('telescope.builtin').keymaps() end,
    desc = 'Search keymaps',
  },
  {
    mode = 'n',
    suffix = 'a',
    command = function() require('telescope.builtin').live_grep() end,
    desc = 'Search content',
  },
  {
    mode = 'n',
    suffix = 'h',
    command = function() require('telescope.builtin').command_history() end,
    desc = 'Search command history',
  },
  {
    mode = 'n',
    suffix = 'l',
    command = function() require('telescope.builtin').loclist() end,
    desc = 'Search location list',
  },
  {
    mode = 'n',
    suffix = 'q',
    command = function() require('telescope.builtin').quickfix() end,
    desc = 'Search quickfix list',
  },
  {
    mode = 'n',
    suffix = 'o',
    command = '<cmd>Telescope orgmode search_headings<cr>',
    desc = 'Search orgmode headings',
  },
  {
    mode = 'n',
    suffix = 'u',
    command = function() require('telescope.builtin').oldfiles() end,
    desc = 'Search previously open files',
  },
  {
    mode = 'n',
    suffix = 'm',
    command = function() require('telescope.builtin').marks() end,
    desc = 'Search marks',
  },
  {
    mode = 'n',
    suffix = 'j',
    command = function() require('telescope.builtin').jumplist() end,
    desc = 'Search jumplist',
  },
  {
    mode = 'n',
    suffix = 'S',
    command = function() require('telescope.builtin').spell_suggest() end,
    desc = 'Search spelling suggestions',
  },
  {
    mode = 'n',
    suffix = '/',
    command = function() require('telescope.builtin').current_buffer_fuzzy_find() end,
    desc = 'Fuzzy search current buffer',
  },
  -- TODO search LSP stuff
}

vim.keymap.set('n', ';', '<cmd>noh<cr>')
vim.keymap.set('n', 'j', 'nzz')
vim.keymap.set('n', 'J', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
