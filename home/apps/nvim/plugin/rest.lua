require("rest-nvim").setup({
  keybinds = {
    { "<localleader>rr", "<cmd>Rest run<cr>", "Run request under the cursor" },
    { "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request" },
  }
})
