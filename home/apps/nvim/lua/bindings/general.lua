-- General bindings

-- easy update and close
vim.keymap.set("n", "<leader>x", "<cmd>xa<cr>")

-- easy paste in insert mode
vim.keymap.set("i", "<c-r>", '<c-r>"')

-- easy date insert in insert mode
vim.keymap.set("i", "<c-q>", '<c-r>=strftime("%H:%M")<c-m>')
vim.keymap.set("i", "<c-x>", '<c-r>=strftime("&%Y-%m-%d %a %H:%M&")<c-m>')

-- rebind increment due to tmux prefix
vim.keymap.set("n", "<c-q>", "<c-a>")

-- Oil support
vim.keymap.set("n", "-", function()
  require("oil").open()
end)
