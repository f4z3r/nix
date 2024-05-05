require("gruvbox-material").setup({
  background = {
    transparent = true,
  },
  float = {
    force_background = true,
  },
})

--- Curser lines
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 208, bold = true, fg = "#e78a4e" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Visual", nocombine = true })

---- Customizations for auto completion windows.
--- Default backgrounds and selection backgrounds.
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4c3432", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#d4be98", bg = "#282828" })
--- grey
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#928374", bg = "NONE", strikethrough = true })
--- matches = light purple
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#d3869b", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
--- type = grey
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#a89984", bg = "NONE" })
--- blue
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#458588", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })
--- grey
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#928374", bg = "NONE" })
--- light red
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#fb4934", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { link = "CmpItemKindEnum" })
--- purple
vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#b16286", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })
--- yellow
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#d79921", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })
--- green
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#98971a", bg = "None" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })
--- aqua
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#689d6a", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })
--- light blue
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#83a598", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })
--- orange
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#d65d0e", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
