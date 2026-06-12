local dap = require("dap")

dap.adapters.lldb = {
  type = "executable",
  command = "lldb-dap",
  name = "lldb",
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input('Arguments: ')
      return input ~= '' and vim.split(input, ' ') or {}
    end,
  }
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

vim.fn.sign_define("DapBreakpoint", { text = "" })
