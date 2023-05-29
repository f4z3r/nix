-- Test bindings

local leader = '<leader>T'

local mappings = {
  {
    mode = 'n',
    suffix = 't',
    command = function() require('neotest').run.run() end,
    desc = 'Test the nearest test',
  },
  {
    mode = 'n',
    suffix = 'T',
    command = function() require('neotest').run.run_last() end,
    desc = 'Test the last test',
  },
  {
    mode = 'n',
    suffix = 'f',
    command = function() require('neotest').run.run(vim.fn.expand("%")) end,
    desc = 'Test the current file',
  },
  {
    mode = 'n',
    suffix = 'd',
    command = function()
      require('neotest').run.run({
        strategy = "dap"
      })
    end,
    desc = 'Debug the nearest test',
  },
  {
    mode = 'n',
    suffix = 'D',
    command = function()
      require('neotest').run.run_last({
        strategy = "dap"
      })
    end,
    desc = 'Debug the last test',
  },
  {
    mode = 'n',
    suffix = 's',
    command = function() require('neotest').run.run(vim.fn.getcwd()) end,
    desc = 'Run entire test suite',
  },
  {
    mode = 'n',
    suffix = 'S',
    command = function() require('neotest').run.stop() end,
    desc = 'Stop currently running test',
  },
  {
    mode = 'n',
    suffix = 'o',
    command = function() require('neotest').summary.toggle() end,
    desc = 'Toggle test summary',
  },
  {
    mode = 'n',
    suffix = 'O',
    command = function() require('neotest').output.toggle() end,
    desc = 'Toggle test output',
  },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode, leader .. mapping.suffix, mapping.command, { desc = mapping.desc })
end
