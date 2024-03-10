-- Setup language servers.

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      format = {
        enable = false,
      },
      doc = {
        privateName = { "_*" },
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          "/home/f4z3r/.local/share/nvim/lua/addons/busted/",
          "/home/f4z3r/.local/share/nvim/lua/addons/luassert/",
        },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
  capabilities = capabilities,
})

-- Nix
lspconfig.nil_ls.setup({
  capabilities = capabilities,
})

-- Python
lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = {
          enabled = true,
        },
      },
    },
  },
  capabilities = capabilities,
})
lspconfig.ruff_lsp.setup({
  capabilities = capabilities,
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
})

-- Markdown
lspconfig.marksman.setup({
  capabilities = capabilities,
})

-- Rust
-- already done by rust-tools

-- Bash
lspconfig.bashls.setup({
  capabilities = capabilities,
})

-- Helm
lspconfig.helm_ls.setup({
  capabilities = capabilities,
})

-- Terraform
lspconfig.terraformls.setup({
  capabilities = capabilities,
})

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
