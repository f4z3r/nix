require("zen-mode").setup({
  window = {
    width = function()
      if vim.opt_local.textwidth:get() > 0 then
        return vim.opt_local.textwidth:get() + 7
      end
      return 120
    end,
    options = {
      -- signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = true, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      laststatus = 0, -- turn off the statusline in zen mode
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = true }, -- disables the tmux statusline
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    vim.opt.sidescrolloff = 0
    vim.opt.sidescroll = 0
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    vim.opt.sidescrolloff = 5
    vim.opt.sidescroll = 1
  end,
})
