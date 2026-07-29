-- Runner bindings

local leader = "<leader>r"

local mappings = {
  {
    mode = "n",
    suffix = "n",
    command = function()
      require("executor").commands.run_with_new_command()
    end,
    desc = "Run new command",
  },
  {
    mode = "n",
    suffix = "r",
    command = function()
      require("executor").commands.run()
    end,
    desc = "Run stored command",
  },
  {
    mode = "n",
    suffix = "t",
    command = function()
      require("executor").commands.toggle_detail()
    end,
    desc = "Toggle runner details",
  },
  {
    mode = "n",
    suffix = "h",
    command = function()
      require("executor").commands.show_history()
    end,
    desc = "Show runner history",
  },
  {
    mode = "n",
    suffix = "s",
    command = function()
      local utils = require("lazy.utils")
      local channel = vim.fn.trim(utils.select_with_tv("channels"))
      local command = vim.fn.trim(utils.select_with_tv(channel))
      local executor = require("executor")
      executor.api.set_task_command(command)
      executor.api.run_task()
    end,
    desc = "Select a command using tv",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
