-- Scrolling settings

vim.o.scrolloff = 8
vim.o.sidescrolloff = 5

-- vim.o.foldcolumn = 0
vim.o.foldenable = true
vim.o.foldlevel = 8
vim.o.foldlevelstart = 8
vim.o.foldmethod = 'expr'
vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
vim.o.foldopen = 'all'
vim.o.foldclose = 'all'
