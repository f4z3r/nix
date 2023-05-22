-- General bindings

vim.keymap.set('n', '<leader>y', function() require('lazy.utils').copy_to_clipboard() end, {
  desc = 'Copy to system clipboard',
})
vim.keymap.set('x', 'p', 'p<cmd>let @"=@0<cr>', {
  silent = true,
})
vim.keymap.set('i', '<c-r>', '<c-r>"')
vim.keymap.set('i', '<c-s>', '<esc>bviwUea')
vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>EasyAlign')
vim.keymap.set('n', '<c-q>', '<cmd>qa<cr>')
vim.keymap.set('n', '-', '<cmd>Neotree<cr>')
vim.keymap.set('n', '+', '<cmd>Neotree close<cr>')
