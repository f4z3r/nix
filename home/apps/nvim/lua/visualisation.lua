-- Color configuration
if vim.env.STY == nil then
  vim.o.termguicolors = true
end

vim.o.t_Co = 256

-- theming
local theme = "dark"
if vim.env.NIX_THEME ~= "" then
  theme = vim.env.NIX_THEME
end
vim.o.background = theme

-- encodings
vim.o.encoding = "UTF-8"

-- column
vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- whitespace
vim.o.listchars = "tab:>\\ ,trail:~,extends:>,precedes:<,nbsp:+"
vim.o.list = true

-- indentation
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.expandtab = true

-- liner ruler
vim.o.number = true
vim.o.relativenumber = false
vim.o.signcolumn = "auto:1-3"

-- folding
vim.o.foldenable = false

-- notifications
local ok, mod = pcall(require, "notify")
if ok then
  vim.notify = mod
end
