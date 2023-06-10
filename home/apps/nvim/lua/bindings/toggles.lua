-- Toggle bindings
--
-- Additional currently defined in plugin/gitsigns

local leader = '<leader>t'

local function toggle_conceal()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end

local function toggle_spell()
  vim.o.spell = not vim.o.spell
end

local function toggle_wrap()
  vim.o.wrap = not vim.o.wrap
end

local mappings = {
  {
    mode = 'n',
    suffix = 't',
    command = '<cmd>TroubleToggle document_diagnostics<cr>',
    desc = 'Toggle document diagnostics',

  },
  {
    mode = 'n',
    suffix = 'd',
    command = function() require('dapui').toggle() end,
    desc = 'Toggle debug UI',
  },
  {
    mode = 'n',
    suffix = 'D',
    command = '<cmd>TroubleToggle workspace_diagnostics<cr>',
    desc = 'Toggle workspace diagnostics',
  },
  {
    mode = 'n',
    suffix = 'm',
    command = function() require('maximize').toggle() end,
    desc = 'Toggle maximization',
  },
  {
    mode = 'n',
    suffix = 'r',
    command = '<cmd>TroubleToggle lsp_references<cr>',
    desc = 'Toggle LSP references',
  },
  {
    mode = 'n',
    suffix = 'r',
    command = function() require('overseer').toggle() end,
    desc = 'Toggle task runner',

  },
  {
    mode = 'n',
    suffix = 'c',
    command = toggle_conceal,
    desc = 'Toggle conceal',
  },
  {
    mode = 'n',
    suffix = 's',
    command = '<cmd>SymbolsOutline<cr>',
    desc = 'Toggle document symbol outline',
  },
  {
    mode = 'n',
    suffix = 'S',
    command = toggle_spell,
    desc = 'Toggle spelling',
  },
  {
    mode = 'n',
    suffix = 'w',
    command = toggle_wrap,
    desc = 'Toggle wrap',
  },
  {
    mode = 'n',
    suffix = 'D',
    command = function() require('dapui').toggle() end,
    desc = 'Toggle DAP UI',
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
    suffix = 'T',
    command = function() require('neotest').summary.toggle() end,
    desc = 'Toggle test ouputs',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end

