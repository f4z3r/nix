require("gruvbox-material").setup({
  background = {
    transparent = true,
  },
  float = {
    force_background = false,
  },
  signs = {
    highlight = false,
  },
})

--- Curser lines
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 208, bold = true, fg = "#e78a4e" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Visual", nocombine = true })

local g_colors = require("gruvbox-material.colors")
local colors = g_colors.get(vim.o.background, "medium")

---- Customizations for auto completion windows.
--- Default backgrounds and selection backgrounds.
vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.bg_visual_red, fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg0, bg = colors.bg0 })

--- Nicer Neotree
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.aqua })
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { link = "FloatTitle" })

--- Nicer HTTP stuff
vim.api.nvim_set_hl(0, "@function.method.http", { fg = colors.red })
