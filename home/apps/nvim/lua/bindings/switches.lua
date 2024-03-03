-- Switches configuration
-- NOTE: some are contained within other binding configurations

-- use `2[C` to move two up the context list
vim.keymap.set('n', '[C', function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = 'Increase foldlevel', silent = true })

vim.keymap.set('n', ']f', 'zr', {
  desc = 'Increase foldlevel',
})
vim.keymap.set('n', '[f', 'zm', {
  desc = 'Decrease foldlevel',
})

vim.keymap.set('n', '[t', function() require('trouble').previous({ skip_groups = true, jump = true }) end, {
  desc = 'Jump to previous entry in trouble list',
})
vim.keymap.set('n', ']t', function() require('trouble').next({ skip_groups = true, jump = true }) end, {
  desc = 'Jump to next entry in trouble list',
})

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Jump to previous diagnostic',
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Jump to next diagnostic',
})
