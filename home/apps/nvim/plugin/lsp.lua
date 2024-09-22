-- Setup language servers.

local border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border,
})

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
  float = { border = border },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  on_init = function(client, _)
    -- disable syntax highlighting via LSP for lua
    client.server_capabilities.semanticTokensProvider = nil
  end,
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
      diagnostics = {
        unusedLocalExclude = { "_*" },
      },
      telemetry = {
        enable = false,
      },
      semantic = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand("~/.local/share/nvim/lua/addons/busted/"),
          vim.fn.expand("~/.local/share/nvim/lua/addons/luassert/"),
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

-- Helm
lspconfig.helm_ls.setup({
  capabilities = capabilities,
  filetypes = { "helm", "gotmpl" },
})

-- Yaml
lspconfig.yamlls.setup({
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
