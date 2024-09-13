local spider = require("spider")

spider.setup({
  skipInsignificantPunctuation = true,
  consistentOperatorPending = false,
})

vim.keymap.set({ "n", "x" }, "w", function()
  spider.motion("w")
end, { desc = "Spider-w" })
vim.keymap.set({ "n", "x" }, "e", function()
  spider.motion("e")
end, { desc = "Spider-e" })
vim.keymap.set({ "n", "x" }, "b", function()
  spider.motion("b")
end, { desc = "Spider-b" })
vim.keymap.set({ "n", "x" }, "ge", function()
  spider.motion("ge")
end, { desc = "Spider-ge" })

vim.keymap.set({ "o" }, "w", function()
  spider.motion("w", { skipInsignificantPunctuation = false })
end, { desc = "Spider-w" })
vim.keymap.set({ "o" }, "e", function()
  spider.motion("e", { skipInsignificantPunctuation = false })
end, { desc = "Spider-e" })
vim.keymap.set({ "o" }, "b", function()
  spider.motion("b", { skipInsignificantPunctuation = false })
end, { desc = "Spider-b" })
vim.keymap.set({ "o" }, "ge", function()
  spider.motion("ge", { skipInsignificantPunctuation = false })
end, { desc = "Spider-ge" })
