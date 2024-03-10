vim.o.showmatch = true
vim.o.matchtime = 0

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.laststatus = 2

vim.o.wrap = false
vim.o.formatoptions = vim.o.formatoptions .. "q"

vim.o.history = 100
vim.o.undofile = true

vim.o.wildmenu = true
vim.o.wildmode = "list:longest,full"

vim.o.hidden = true
vim.o.autoread = true

vim.o.autochdir = false
vim.o.tags = "tags;/"

vim.o.secure = true
vim.o.mouse = nil

vim.g.clipboard = {
  name = "xsel_override",
  copy = {
    ["+"] = "xsel --input --clipboard",
    ["*"] = "xsel --input --primary",
  },
  paste = {
    ["+"] = "xsel --output --clipboard",
    ["*"] = "xsel --output --primary",
  },
  cache_enabled = 1,
}
