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

vim.keymap.set("n", "]]", require("marks").next_bookmark0, {
  desc = "Jump to next JUMP bookmark",
})
vim.keymap.set("n", "[[", require("marks").prev_bookmark0, {
  desc = "Jump to previous JUMP bookmark",
})
