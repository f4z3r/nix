-- Setup language servers.

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  -- on_init = function(client)
  --   local path = client.workspace_folders[1].name
  --   if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
  --     return
  --   end
  --
  --   client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
  --     diagnostics = {
  --       globals = { "vim" },
  --     },
  --     workspace = {
  --       checkThirdParty = false,
  --       library = {
  --         vim.env.VIMRUNTIME
  --         -- TODO add busted here
  --         -- Depending on the usage, you might want to add additional paths here.
  --         -- "${3rd}/busted/library",
  --       }
  --     }
  --   })
  -- end,
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
