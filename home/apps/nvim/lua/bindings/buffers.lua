-- Buffer bindings

local leader = "<leader>b"

local mappings = {
  {
    mode = "n",
    suffix = "s",
    command = "ggVG",
    desc = "Select the entire buffer",
  },
  {
    mode = "n",
    suffix = "y",
    command = "ggVGy",
    desc = "Yank the entire buffer",
  },
  {
    mode = "n",
    suffix = "k",
    command = [[<cmd>execute '%bdelete|edit #|normal `"'<cr>]],
    desc = "Keep only the current buffer",
  },
  {
    mode = "n",
    suffix = "b",
    command = function()
      require("neo-tree.command").execute({
        source = "buffers",
        toggle = true,
        action = "focus",
        reveal = true,
      })
    end,
    desc = "Toggle buffer sidepane",
  },
}

vim.keymap.set("n", "<leader><tab>", "<cmd>b#<cr>", {
  desc = "Switch to previous buffer",
})

vim.keymap.set("n", "<c-b>", function()
  require("telescope.builtin").buffers()
end, {
  desc = "Open loaded buffer",
})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
