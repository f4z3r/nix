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
  vim.api.nvim_set_hl(0, "IndentRainbowRed", { link = "RainbowDelimiterRed", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowOrange", { link = "RainbowDelimiterOrange", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowYellow", { link = "RainbowDelimiterYellow", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowGreen", { link = "RainbowDelimiterGreen", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowCyan", { link = "RainbowDelimiterCyan", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowBlue", { link = "RainbowDelimiterBlue", nocombine = true })
  vim.api.nvim_set_hl(0, "IndentRainbowViolet", { link = "RainbowDelimiterViolet", nocombine = true })
end)

require("ibl").setup({
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
    },
  },
})
