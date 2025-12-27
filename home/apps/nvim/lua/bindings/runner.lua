-- Runner bindings

local leader = "<leader>r"

local mappings = {
  {
    mode = "n",
    suffix = "r",
    command = function()
      require("overseer").run_task()
    end,
    desc = "Run a task from templates",
  },
  {
    mode = "n",
    suffix = "l",
    command = "<cmd>OverseerRestartLast<cr>",
    desc = "Run last task again",
  },
  {
    mode = "n",
    suffix = "t",
    command = require("overseer").toggle,
    desc = "Toggle task runner",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
