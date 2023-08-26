local flash = require('flash')
local opts = {
  labels = 'arstneiogmqwfpluy',
  jump = {
    nohlsearch = true,
  },
  label = {
    after = false,
    before = true,
  },
}

vim.keymap.set(
  { 'n', 'x', 'o' },
  '<leader><leader>',
  function()
    flash.jump(opts)
  end,
  { desc = 'Flash to anywhere on the screen' }
)

vim.keymap.set(
  { 'n', 'x', 'o' },
  's',
  function()
    flash.treesitter(opts)
  end,
  { desc = 'Trigger treesitter Flash' }
)

vim.api.nvim_set_hl(0, "FlashMatch", { link = "CursorLineNr", nocombine = true })
vim.api.nvim_set_hl(0, "FlashLabel", { link = "DiffText", nocombine = true })
vim.api.nvim_set_hl(0, "FlashCurrent", { link = "IncSearch", nocombine = true })
