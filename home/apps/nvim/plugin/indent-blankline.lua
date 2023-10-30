local highlight = {
  "IndentRainbowRed",
  "IndentRainbowOrange",
  "IndentRainbowYellow",
  "IndentRainbowGreen",
  "IndentRainbowCyan",
  "IndentRainbowBlue",
  "IndentRainbowViolet",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IndentRainbowRed',     { link = "TSRainbowRed",    nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowOrange',  { link = "TSRainbowOrange", nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowYellow',  { link = "TSRainbowYellow", nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowGreen',   { link = "TSRainbowGreen",  nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowCyan',    { link = "TSRainbowCyan",   nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowBlue',    { link = "TSRainbowBlue",   nocombine = true })
  vim.api.nvim_set_hl(0, 'IndentRainbowViolet',  { link = "TSRainbowViolet", nocombine = true })
end)

require("ibl").setup {
  indent = {
    highlight = highlight,
    char = "┊",
    priority = 2,
  },
  scope = {
    enabled = false,
  },
  exclude = {
    filetypes = {
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "man",
      "gitcommit",
      "TelescopePrompt",
      "TelescopeResults",
      "''",
      "alpha",
    }
  },
}
