local mapping = require("yanky.telescope.mapping")

require('yanky').setup({
  ring = {
    history_length = 50,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update",
  },
  picker = {
    select = {
      action = nil,
    },
    telescope = {
      use_default_mappings = false,
      mappings = {
        default = mapping.put("p"),
        i = { },
        n = {
          p = mapping.put("p"),
          P = mapping.put("P"),
          d = mapping.delete(),
        },
      }
    }
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 300,
  },
  preserve_cursor_position = {
    enabled = true,
  },
})

vim.keymap.set({"n","x"}, "y",         "<Plug>(YankyYank)")
vim.keymap.set({"n","x"}, "p",         "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P",         "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp",        "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP",        "<Plug>(YankyGPutBefore)")
vim.keymap.set("n",       "<leader>p", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n",       "<leader>P", "<Plug>(YankyCycleForward)")

vim.api.nvim_set_hl(0, 'YankyYanked', { link = "TelescopeSelection",    nocombine = true })
vim.api.nvim_set_hl(0, 'YankyPut',    { link = "TelescopeSelection",    nocombine = true })
