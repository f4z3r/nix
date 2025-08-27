local os = require("os")

local transparent_background = true

if os.getenv("NIX_OPAQUE_NVIM") then
  transparent_background = false
end

require("gruvbox-material").setup({
  background = {
    transparent = transparent_background,
  },
})

--- Curser lines
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 208, bold = true, fg = "#e78a4e" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Visual", nocombine = true })

local g_colors = require("gruvbox-material.colors")
local colors = g_colors.get(vim.o.background, "medium")

vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.bg_visual_red, fg = "NONE" })

--- Nicer Neotree
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.aqua })
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { link = "FloatTitle" })

--- Nicer HTTP stuff
vim.api.nvim_set_hl(0, "@function.method.http", { fg = colors.red })
