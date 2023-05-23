-- Switches configuration
-- NOTE: some are contained within other binding configurations

vim.keymap.set('n', ']f', 'zr', {
  desc = 'Increase foldlevel',
})
vim.keymap.set('n', '[f', 'zm', {
  desc = 'Decrease foldlevel',
})

-- errors and diagnostics, warnings
