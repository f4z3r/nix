vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { link = "TSRainbowRed", nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { link = "TSRainbowOrange", nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { link = "TSRainbowYellow", nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { link = "TSRainbowGreen", nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent5', { link = "TSRainbowCyan", nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent6', { link = "TSRainbowBlue", nocombine = true })

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
