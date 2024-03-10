-- Locationlist bindings

local leader = "<leader>l"

local mappings = {
  {
    mode = "n",
    suffix = "l",
    command = "<cmd>TroubleToggle loclist<cr>",
    desc = "Search location list",
  },
  {
    mode = "n",
    suffix = "/",
    command = function()
      require("telescope.builtin").loclist()
    end,
    desc = "Search location list",
  },
  {
    mode = "n",
    suffix = "o",
    command = "<cmd>lopen<cr>",
    desc = "Open location list",
  },
  {
    mode = "n",
    suffix = "c",
    command = "<cmd>lclose<cr>",
    desc = "Close location list",
  },
}

vim.keymap.set("n", "]l", "<cmd>lnext<cr>", {
  desc = "Move to next entry in location list",
})
vim.keymap.set("n", "[l", "<cmd>lprevious<cr>", {
  desc = "Move to previous entry in location list",
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
