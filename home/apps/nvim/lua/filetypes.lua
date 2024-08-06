vim.filetype.add({
  filename = {
    ["Justfile"] = "just",
    ["justfile"] = "just",
    ["helmfile.yaml"] = "gotmpl",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "gotmpl",
    [".*/templates/.*%.yaml"] = "gotmpl",
    [".*%.http"] = "http",
  }
})
