-- Git bindings

local leader = "<leader>g"

local mappings = {
  {
    mode = "n",
    suffix = "g",
    command = function()
      require("telescope.builtin").git_status()
    end,
    desc = "Search git modified files",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
