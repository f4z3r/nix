require("yanky").setup({
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

vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

local function put_history_to_reg()
  local history = {}
  for _, value in pairs(require("yanky.history").all()) do
    if #history > 40 then
      break
    elseif value.regcontents then
      -- switch newlines to avoid splitting into two options
      history[#history + 1] = value.regcontents:gsub("\n", "<cr>")
    end
  end
  local utils = require("lazy.utils")
  local selected = assert(utils.select_with_tv(history), "tv did not resturn anything")
  selected = selected:match("^(.-)\n$")
  local text = selected:gsub("<cr>", "\n")
  vim.fn.setreg('"', text)
end

vim.keymap.set("n", "<leader>p", put_history_to_reg)

vim.api.nvim_set_hl(0, "YankyYanked", { link = "DiffDelete", nocombine = true })
vim.api.nvim_set_hl(0, "YankyPut", { link = "DiffChange", nocombine = true })
