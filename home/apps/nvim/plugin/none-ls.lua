local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- code actions
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.code_actions.refactoring,
    -- diagnostics
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.revive,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.tfsec,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space,
    -- formatting
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.terraform_fmt,
  }
})
