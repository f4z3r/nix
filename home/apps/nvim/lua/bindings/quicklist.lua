-- Quicklist bindings

local leader = "<leader>q"

local mappings = {
  {
    mode = "n",
    suffix = "q",
    command = "<cmd>TroubleToggle quickfix<cr>",
    desc = "Search quickfix list",
  },
  {
    mode = "n",
    suffix = "/",
    command = function()
      require("telescope.builtin").quickfix()
    end,
    desc = "Search quickfix list",
  },
  {
    mode = "n",
    suffix = "o",
    command = "<cmd>copen<cr>",
    desc = "Open quickfix list",
  },
  {
    mode = "n",
    suffix = "c",
    command = "<cmd>cclose<cr>",
    desc = "Close quickfix list",
  },
}

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", {
  desc = "Move to next entry in quickfix list",
})
vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", {
  desc = "Move to previous entry in quickfix list",
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
