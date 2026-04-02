require("executor").setup({
  use_split = true,
  split = {
    position = "right",
    size = math.floor(vim.o.columns * 1 / 4),
  },

  popup = {
    width = math.floor(vim.o.columns * 3 / 5),
    height = vim.o.lines - 20,
    border = {
      padding = {
        top = 2,
        bottom = 2,
        left = 3,
        right = 3,
      },
      style = "rounded",
    },
  },
  output_filter = function(command, lines)
    return lines
  end,

  notifications = {
    task_started = true,
    task_completed = true,
    border = {
      padding = {
        top = 0,
        bottom = 0,
        left = 1,
        right = 1,
      },
      style = "rounded",
    },
  },
})
