-- Search bindings

local leader = "<leader>/"

local mappings = {
  {
    mode = "n",
    suffix = "g",
    command = function()
      require("tv").tv_channel("git-log")
    end,
    desc = "Search git commits",
  },
  {
    mode = "n",
    suffix = "a",
    command = function()
      require("tv").tv_channel("text")
    end,
    desc = "Search content",
  },
  {
    mode = "n",
    suffix = "t",
    command = function()
      require("tv").tv_channel("text", " TODO: ")
    end,
    desc = "Search todos",
  },
}

vim.keymap.set("n", ";", "<cmd>noh<cr>")
vim.keymap.set("n", "j", "nzz")
vim.keymap.set("n", "J", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")

vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, {
  desc = "Toggle flash in regular search",
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
