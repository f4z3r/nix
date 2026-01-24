local resession = require("resession")
resession.setup()

local BLACKLIST_FILES = {
  ".git/COMMIT_EDITMSG$"
}

local BLACKLIST_DIRECTORIES = {
  "^/home/f4z3r/?$"
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only load the session if nvim was started with no args and without reading from stdin
    if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
      -- Save these to a different directory, so our manual sessions don't get polluted
      resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
    end
  end,
  nested = true,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local filepath = vim.fn.expand('%:p')
    for _, item in ipairs(BLACKLIST_FILES) do
      if filepath:match(item) ~= nil then
        return
      end
    end
    local cwd = vim.fn.getcwd()
    for _, item in ipairs(BLACKLIST_DIRECTORIES) do
      if cwd:match(item) ~= nil then
        return
      end
    end
    resession.save(cwd, { dir = "dirsession", notify = false })
  end,
})
vim.api.nvim_create_autocmd('StdinReadPre', {
  callback = function()
    -- Store this for later
    vim.g.using_stdin = true
  end,
})
