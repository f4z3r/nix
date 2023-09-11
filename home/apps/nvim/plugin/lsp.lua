-- Setup language servers.

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
})

local lspconfig = require("lspconfig")

-- LUA
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "?.lua")
-- table.insert(runtime_path, "?/init.lua")
--
-- local system_lib_path = vim.split(vim.env.LUA_PATH, ";")
-- table.insert(system_lib_path, vim.api.nvim_get_runtime_file("", true))
--
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      }
    },
  },
})

-- Nix
lspconfig.rnix.setup({})

-- Python
lspconfig.jedi_language_server.setup({})

-- Go
lspconfig.gopls.setup({})

-- Markdown
lspconfig.marksman.setup({})

-- Rust
-- already done by rust-tools

-- Bash
lspconfig.bashls.setup({})

-- Helm
lspconfig.helm_ls.setup({})

-- Terraform
lspconfig.terraformls.setup({})

local signs = {
  Error = "",
  Warn = "",
  Hint = "󰌶",
  Info = "",
  Ok = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
