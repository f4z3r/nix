-- Locationlist bindings

local leader = "<leader>l"

local mappings = {
  {
    mode = "n",
    suffix = "l",
    command = "<cmd>Trouble loclist toggle<cr>",
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
    suffix = "t",
    command = "<cmd>Trouble todo<cr>",
    desc = "Add todos to location list",
  },
  {
    mode = "n",
    suffix = "s",
    command = function()
      require("telescope.builtin").loclist()
    end,
    desc = "Search location list",
  },
  {
    mode = "n",
    suffix = "a",
    command = function()
      local item = {
        bufnr = vim.fn.bufnr("%"),
        filename = vim.fn.expand("%"),
        lnum = vim.fn.line("."),
        valid = true,
        comment = "added manually",
      }
      vim.fn.setloclist(0, {item}, "a")
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
