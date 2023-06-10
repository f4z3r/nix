-- General bindings

vim.keymap.set('n', '<leader>y', function() require('lazy.utils').copy_to_clipboard() end, {
  desc = 'Copy to system clipboard',
})

-- easy paste in insert mode
vim.keymap.set('i', '<c-r>', '<c-r>"')

-- change to upper case
vim.keymap.set('i', '<c-s>', '<esc>bviwUea')

-- rebind increment due to tmux prefix
vim.keymap.set('n', '<c-q>', '<c-a>')

-- neotree support
vim.keymap.set('n', '-', '<cmd>Neotree<cr>')
vim.keymap.set('n', '+', '<cmd>Neotree close<cr>')

vim.keymap.set('n', 'z=', function() require('telescope.builtin').spell_suggest() end)
