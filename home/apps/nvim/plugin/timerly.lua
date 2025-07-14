local timerly = require('timerly')
timerly.setup({
  position = "bottom-right",
  mapping = function(buf)
    vim.keymap.set("n", "q", timerly.toggle, { buffer = buf })
  end,
})
