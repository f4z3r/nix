local overseer = require("overseer")

overseer.setup({})

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

-- busted
overseer.register_template({
  name = "Busted",
  builder = function(_)
    return {
      cmd = { "busted" },
      args = { "./" },
      name = "Busted",
      cwd = vim.fn.getcwd(),
      -- env = {
      --   VAR = "FOO",
      -- },
      components = { "default" },
      -- metadata = {
      --   foo = "bar",
      -- },
    }
  end,
  desc = "Run busted in the current working directory",
  tags = { "TEST" },
  params = {
    -- See :help overseer-params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  -- priority = 50,
  condition = {
    -- A string or list of strings
    filetype = { "lua" },
    -- Arbitrary logic for determining if task is available
    callback = function(search)
      print(vim.inspect(search))
      return true
    end,
  },
})
