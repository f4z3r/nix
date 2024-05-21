-- Git bindings
--
-- These are currently defined in plugin/gitsigns

local leader = "<leader>g"

local mappings = {
  {
    mode = "n",
    suffix = "g",
    command = function()
      require("neo-tree.command").execute({
        source = "git_status",
        action = "focus",
        position = "float",
        toggle = true,
      })
    end,
    desc = "Toggle git status",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
