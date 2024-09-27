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

--- Navic
vim.api.nvim_set_hl(0, "NavicIconsFile",          {link = "CmpItemKindFile", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsModule",        {link = "CmpItemKindModule", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {link = "CmpItemKindUnit", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsPackage",       {link = "CmpItemKindModule", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsClass",         {link = "CmpItemKindClass", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsMethod",        {link = "CmpItemKindMethod", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsProperty",      {link = "CmpItemKindProperty", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsField",         {link = "CmpItemKindField", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {link = "CmpItemKindConstructor", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsEnum",          {link = "CmpItemKindEnum", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsInterface",     {link = "CmpItemKindInterface", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsFunction",      {link = "CmpItemKindFunction", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsVariable",      {link = "CmpItemKindVariable", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsConstant",      {link = "CmpItemKindConstant", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsString",        {link = "CmpItemKindText", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsNumber",        {link = "CmpItemKindValue", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {link = "CmpItemKindValue", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsArray",         {link = "CmpItemKindUnit", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsObject",        {link = "CmpItemKindStruct", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsKey",           {link = "CmpItemKindEnumMember", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsNull",          {link = "CmpItemKindValue", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {link = "CmpItemKindEnumMember", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsStruct",        {link = "CmpItemKindStruct", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsEvent",         {link = "CmpItemKindEvent", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsOperator",      {link = "CmpItemKindOperator", nocombine = true})
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {link = "CmpItemKindTypeParameter", nocombine = true})
vim.api.nvim_set_hl(0, "NavicText",               {link = "CmpItemKindText", nocombine = true})
vim.api.nvim_set_hl(0, "NavicSeparator",          {link = "CmpItemKindFile", nocombine = true})
