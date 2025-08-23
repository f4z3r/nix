require("oil-git").setup({
  ignore_git_signs = true,
  highlights = {
    OilGitAdded = { link = "Green" },
    OilGitModified = { link = "Yellow" },
    OilGitDeleted = { link = "Red" },
    OilGitRenamed = { link = "Purple" },
    OilGitUntracked = { link = "Blue" },
    OilGitIgnored = { link = "Grey" },
  }
})
