require("nvim-treesitter-textsubjects").configure({
  prev_selection = ",",
  keymaps = {
    ["."] = "textsubjects-smart",
    [";"] = "textsubjects-container-outer",
    ["i;"] = "textsubjects-container-inner",
  },
})
