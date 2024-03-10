require("org-bullets").setup({
  concealcursor = false,
  symbols = {
    headlines = { "", "󰪥", "󰻂", "󰺕", "○" },
    checkboxes = {
      half = { "", "OrgTSCheckboxHalfChecked" },
      done = { "", "OrgDone" },
      todo = { " ", "OrgTODO" },
    },
  },
})
