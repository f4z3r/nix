local timerly = require("timerly")
timerly.setup({
  position = "bottom-right",
  mapping = function(buf)
    vim.keymap.set("n", "q", timerly.toggle, { buffer = buf })
  end,
  on_finish = function()
    require("lazy.utils").run("notify-send NeoVim \"Time's up!\" -u critical -t 0 -a nvim -i nvim")
    vim.notify("Time's up!", vim.log.levels.ERROR, {
      title = "Timerly",
      timeout = 0,
    })
  end,
})
