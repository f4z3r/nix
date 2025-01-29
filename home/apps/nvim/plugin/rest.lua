require("rest-nvim").setup({
  ---@type table<string, fun():string> Table of custom dynamic variables
  custom_dynamic_variables = {
    -- see base https://github.com/rest-nvim/rest.nvim/blob/472913298be47e56d9b9a65fa3156c08cbc9a772/lua/rest-nvim/context.lua#L33
  },
  request = {
    skip_ssl_verification = false,
    hooks = {
      encode_url = true,
      set_content_type = true,
    },
  },
  response = {
    hooks = {
      decode_url = true,
      format = true,
    },
  },
  clients = {
    curl = {
      statistics = {
        { id = "time_total", winbar = "take", title = "Time taken" },
        { id = "size_download", winbar = "size", title = "Download size" },
      },
    },
  },
  env = {
    enable = true,
    pattern = ".*%.env.*",
  },
  ui = {
    winbar = true,
    keybinds = {
      prev = "<S-Tab>",
      next = "<Tab>",
    },
  },
  highlight = {
    enable = true,
    timeout = 750,
  },
})

vim.keymap.set("n", "<localleader>rr", "<cmd>Rest run<cr>", { desc = "Run rest request under the cursor" })
vim.keymap.set("n", "<localleader>rl", "<cmd>Rest last<cr>", { desc = "Re-run latest rest request" })
vim.keymap.set(
  "n",
  "<localleader>re",
  require("telescope").extensions.rest.select_env,
  { desc = "Select rest environment" }
)
