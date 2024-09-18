-- Diagnostics bindings

local leader = "<leader>d"

local mappings = {
  -- dr taken for rename
  {
    mode = "n",
    suffix = "d",
    command = vim.diagnostic.open_float,
    desc = "Show diagnostics in float",
  },
  {
    mode = "n",
    suffix = "l",
    command = vim.diagnostic.setloclist,
    desc = "Set location list for diagnostics",
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- enable completion
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- diagnostics (debug/errors/refactor) commands
    vim.keymap.set("n", "<leader>dr", vim.lsp.buf.rename, {
      buffer = ev.buf,
      desc = "rename symbol under cursor",
    })
    vim.keymap.set({ "n", "v" }, "<leader>aa", vim.lsp.buf.code_action, {
      buffer = ev.buf,
      desc = "perform code action",
    })
    vim.keymap.set("n", "<leader>df", function()
      vim.lsp.buf.format({ async = true, timeout_ms = 1000 })
    end, {
      buffer = ev.buffer,
      desc = "format current buffer",
    })

    -- signature help
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, {
      buffer = ev.buffer,
      desc = "show signature help",
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = ev.buffer,
      desc = "show hover information",
    })

    -- goto commands prefixed with g
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = ev.buffer,
      desc = "go to declaration",
    })
    vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>", {
      buffer = ev.buffer,
      desc = "go to definition in trouble",
    })
    vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>", {
      buffer = ev.buffer,
      desc = "go to implementation in trouble",
    })
    vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>", {
      buffer = ev.buffer,
      desc = "go to references in trouble",
    })
  end,
})
