-- Diagnostics bindings

local leader = "<leader>d"

local mappings = {
  -- dr and da taken for rename and actions
  {
    mode = 'n',
    suffix = 'd',
    command = vim.diagnostic.open_float,
    desc = 'Show diagnostics in float'
  },
  {
    mode = 'n',
    suffix = 'l',
    command = vim.diagnostic.setloclist,
    desc = 'Set location list for diagnostics'
  },
  {
    mode = 'n',
    suffix = 'L',
    command = function() require('osv').run_this() end,
    desc = 'Debug a lua file with OSV',
  },
  {
    mode = 'n',
    suffix = 'b',
    command = function() require('dap').toggle_breakpoint() end,
    desc = 'Toggle breakpoint'
  },
  {
    mode = 'n',
    suffix = 'Bc',
    command = function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    desc = 'DAP set breakpoint with condition'
  },
  {
    mode = 'n',
    suffix = 'Bl',
    command = function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    desc = 'DAP set breakpoint with log message'
  },
  {
    mode = 'n',
    suffix = 'c',
    command = function() require('dap').continue() end,
    desc = 'DAP continue'
  },
  {
    mode = 'n',
    suffix = 's',
    command = function() require('dap').step_over() end,
    desc = 'DAP step over'
  },
  {
    mode = 'n',
    suffix = 'Si',
    command = function() require('dap').step_into() end,
    desc = 'DAP step into'
  },
  {
    mode = 'n',
    suffix = 'So',
    command = function() require('dap').step_out() end,
    desc = 'DAP step out'
  },
  {
    mode = 'n',
    suffix = 'R',
    command = function() require('dap').run_last() end,
    desc = 'DAP run last'
  },
  {
    mode = 'n',
    suffix = 'O',
    command = function() require('dap').repl.open() end,
    desc = 'DAP open REPL'
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
      buffer = ev.buf, desc = "rename symbol under cursor"
    })
    vim.keymap.set({ "n", "v" }, "<leader>da", vim.lsp.buf.code_action, {
      buffer = ev.buf, desc = "perform code action"
    })
    vim.keymap.set("n", "<leader>df", function()
      vim.lsp.buf.format({ async = true, timeout_ms = 1000 })
    end, {
      buffer = ev.buffer, desc = "format current buffer"
    })

    -- signature help
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, {
      buffer = ev.buffer, desc = "show signature help"
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = ev.buffer, desc = "show hover information"
    })

    -- goto commands prefixed with g
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = ev.buffer, desc = "go to declaration"
    })
    vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>", {
      buffer = ev.buffer, desc = "go to definition in trouble"
    })
    vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>", {
      buffer = ev.buffer, desc = "go to implementation in trouble"
    })
    vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>", {
      buffer = ev.buffer, desc = "go to references in trouble"
    })
  end,
})
