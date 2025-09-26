vim.filetype.add({
  filename = {
    ["Justfile"] = "just",
    ["justfile"] = "just",
    ["helmfile.yaml"] = "helm",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.yaml"] = "helm",
  },
  extension = {
    http = "http",
  }
})
