-- Commands bindings

local leader = "<leader>c"

local mappings = {
  {
    mode = "n",
    suffix = "c",
    command = function()
      require("telescope.builtin").command_history()
    end,
    desc = "Search command history",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
