-- Debug Adapter Protocol bindings (T)est

local leader = "<leader>t"

local dap = require('dap')

local mappings = {
  {
    mode = "n",
    suffix = "t",
    command = dap.toggle_breakpoint,
    desc = "Toggle a breakpoint",
  },
  {
    mode = "n",
    suffix = "B",
    command = dap.clear_breakpoints,
    desc = "Remove all breakpoints",
  },
  {
    mode = "n",
    suffix = "c",
    command = dap.continue,
    desc = "Continue execution",
  },
  {
    mode = "n",
    suffix = "o",
    command = dap.step_over,
    desc = "Step over the next function call",
  },
  {
    mode = "n",
    suffix = "i",
    command = dap.step_into,
    desc = "Step into the next function call",
  },
  {
    mode = "n",
    suffix = "f",
    command = dap.step_out,
    desc = "Step out (finish) the current function call",
  },
  {
    mode = "n",
    suffix = "r",
    command = dap.repl.open,
    desc = "Open a REPL for DAP",
  },
  {
    mode = "n",
    suffix = "q",
    command = dap.terminate,
    desc = "Stop the debugging session",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
