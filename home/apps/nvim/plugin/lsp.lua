-- Setup language servers.

local border = "single"

local navic = require("nvim-navic")

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

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

local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  on_init = function(client, _)
    -- disable syntax highlighting via LSP for lua
    client.server_capabilities.semanticTokensProvider = nil
  end,
  on_attach = on_attach,
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
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = {"alejandra", "--quiet"},
      },
    },
  },
})

-- dprint
lspconfig.dprint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "markdown",
    "python",
    "toml",
    "rust",
    "roslyn",
    "graphql",
    "css",
    "yaml",
    "html",
  },
})

-- Typst
lspconfig.tinymist.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
  on_attach = on_attach,
})
lspconfig.ruff.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
  on_attach = on_attach,
})

-- Markdown
lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Helm
lspconfig.helm_ls.setup({
  capabilities = capabilities,
  filetypes = { "helm", "gotmpl" },
  on_attach = on_attach,
})

-- Yaml
lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Terraform
lspconfig.terraformls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Harper
lspconfig.harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      fileDictPath = "",
      linters = {
        BoringWords = true,
      },
      codeActions = {
        ForceStable = false
      },
      markdown = {
        IgnoreLinkTitle = false
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "British",
    },
  },
  filetypes = { "norg", "markdown", "asciidoc" },
  capabilities = capabilities,
  on_attach = on_attach,
}

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
