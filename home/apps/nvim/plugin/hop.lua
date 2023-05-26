local hop = require('hop')
hop.setup({
  keys = 'arstneiogmqwfpluy',
  quit_key = '<c-y>',
  uppercase_labels = true,
})

vim.keymap.set('n', '<leader><leader>', hop.hint_char2, {
  desc = 'Hop to any two character element'
})
