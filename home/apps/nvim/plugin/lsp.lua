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

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.enable('beancount')

vim.lsp.config("lua_ls", {
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
vim.lsp.enable('lua_ls')

-- Nix
vim.lsp.config("nil_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra", "--quiet" },
      },
    },
  },
})
vim.lsp.enable('nil_ls')

-- dprint
vim.lsp.config("dprint", {
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
vim.lsp.enable('dprint')

-- Typst
vim.lsp.config("tinymist", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('tinymist')

-- Python
vim.lsp.config("pylsp", {
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
vim.lsp.enable('pylsp')

vim.lsp.config("ruff", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('ruff')

-- Go
vim.lsp.config("gopls", {
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
vim.lsp.enable('gopls')

-- Markdown
vim.lsp.config("marksman", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('marksman')

-- Rust
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('rust_analyzer')

-- Helm
vim.lsp.config("helm_ls", {
  capabilities = capabilities,
  filetypes = { "helm", "gotmpl" },
  on_attach = on_attach,
})
vim.lsp.enable('helm_ls')

-- Yaml
vim.lsp.config("yamlls", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('yamlls')

-- Terraform
vim.lsp.config("terraformls", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('terraformls')

-- Harper
vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      fileDictPath = "",
      linters = {
        BoringWords = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "British",
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable('harper_ls')

local sign_to_configure = {
  Error = "",
  Warn = "",
  Hint = "󰌶",
  Info = "",
}
-- do not use linehl to highlight entire line
local diagnostic_signs = {
  text = {},
  texthl = {},
  numhl = {},
}
for type, icon in pairs(sign_to_configure) do
  local hl = "DiagnosticSign" .. type
  local level = vim.diagnostic.severity[string.upper(type)]
  diagnostic_signs.text[level] = icon
  diagnostic_signs.texthl[level] = hl
  diagnostic_signs.numhl[level] = hl
end
vim.diagnostic.config({
  signs = diagnostic_signs,
})

local signs_to_create = {
  Ok = "",
}
for type, icon in pairs(signs_to_create) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

