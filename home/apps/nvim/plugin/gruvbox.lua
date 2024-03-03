require('gruvbox-material').setup()

vim.api.nvim_set_hl(0, 'CursorLineNr', { ctermfg = 208, bold = true, fg = "#e78a4e" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Visual", nocombine = true })

local mapping = {
  ['@markup.heading.1'] = { link = "Orange", default = true },
  ['@markup.heading.2'] = { link = "Green", default = true },
  ['@markup.heading.3'] = { link = "Aqua", default = true },
  ['@markup.heading.4'] = { link = "Red", default = true },
  ['@markup.heading.5'] = { link = "Purple", default = true },
  ['@markup.heading.6'] = { link = "Yellow", default = true },
  ['@markup.link'] = { link = "@text.uri", default = true },
  ['@markup.link.url'] = { link = "@text.uri", default = true },
  ['@markup.list'] = { link = "Orange", default = true },
  ['@markup.list.checked'] = { link = "Green", default = true },
  ['@markup.list.numbered'] = { link = "Aqua", default = true },
  ['@markup.list.unchecked'] = { link = "Red", default = true },
  ['@markup.list.unnumbered'] = { link = "Orange", default = true },
  ['@markup.quote'] = { link = "jsonQuote", default = true },
  ['@markup.raw'] = { link = "IndentRainbowViolet", default = true },
  ['@markup.raw.inline'] = { link = "IndentRainbowViolet", default = true },
  ['@markup.raw.block'] = { link = "IndentRainbowViolet", default = true },
  ['@markup.bold'] = { link = "markdownBold", default = true },
  ['@markup.italic'] = { link = "markdownItalic", default = true },
  ['@punctuation.special'] = { link = "Aqua", default = true },
}

for key, value in pairs(mapping) do
  vim.api.nvim_set_hl(0, key, value)
end
