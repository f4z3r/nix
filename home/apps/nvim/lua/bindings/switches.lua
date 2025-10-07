-- Switches configuration
-- NOTE: some are contained within other binding configurations

vim.keymap.set("n", "]f", "zr", {
  desc = "Increase foldlevel",
})
vim.keymap.set("n", "[f", "zm", {
  desc = "Decrease foldlevel",
})

vim.keymap.set("n", "[t", function()
  require("trouble").prev({ skip_groups = true, jump = true })
end, {
  desc = "Jump to previous entry in trouble list",
})
vim.keymap.set("n", "]t", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, {
  desc = "Jump to next entry in trouble list",
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
  desc = "Jump to previous diagnostic",
})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
  desc = "Jump to next diagnostic",
})

vim.keymap.set("n", "[o", function()
  require("todo-comments").jump_prev()
end, {
  desc = "Jump to previous todo item",
})
vim.keymap.set("n", "]o", function()
  require("todo-comments").jump_next()
end, {
  desc = "Jump to next todo item",
})

vim.keymap.set("n", "[m", function()
  require("marks").prev()
end, {
  desc = "Jump to previous mark, this is a duplicate of [[",
})
vim.keymap.set("n", "]m", function()
  require("marks").next()
end, {
  desc = "Jump to next mark, this is a duplicate of ]]",
})
