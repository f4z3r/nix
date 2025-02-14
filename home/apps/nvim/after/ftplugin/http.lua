local leader = "<leader>a"

local mappings = {
  {
    mode = "n",
    suffix = "r",
    command = function()
      require("kulala").run()
    end,
    desc = "Run the HTTP request under cusor",
  },
  {
    mode = "n",
    suffix = "l",
    command = function()
      require("kulala").replay()
    end,
    desc = "Run the last HTTP request",
  },
  {
    mode = "n",
    suffix = "s",
    command = function()
      require("kulala").show_stats()
    end,
    desc = "Show the stats of the last HTTP request",
  },
  {
    mode = "n",
    suffix = "e",
    command = function()
      require("kulala").set_selected_env()
    end,
    desc = "Set an environment for requests",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc, noremap = true })
end
