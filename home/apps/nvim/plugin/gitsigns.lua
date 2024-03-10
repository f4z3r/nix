require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    -- map('n', '<leader>hs', gs.stage_hunk)
    map("n", "<leader>gr", gs.reset_hunk, {
      desc = "Git reset hunk",
    })
    -- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    -- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map("n", "<leader>gs", gs.stage_buffer, {
      desc = "Git stage buffer",
    })
    -- map('n', '<leader>hu', gs.undo_stage_hunk)
    -- map('n', '<leader>hR', gs.reset_buffer)
    -- map('n', '<leader>hp', gs.preview_hunk)
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, {
      desc = "Git blame entire buffer",
    })
    map("n", "<leader>gB", gs.toggle_current_line_blame, {
      desc = "Git blame toggle line",
    })
    map("n", "<leader>gd", gs.diffthis, {
      desc = "Git diff buffer",
    })
    -- map('n', '<leader>gD', function() gs.diffthis('~') end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {
      desc = "Select inner git hunk",
    })
  end,
})
