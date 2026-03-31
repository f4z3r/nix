local tv = require("tv")

local h = tv.handlers

local NOTES_DIR = "notes"
local TITLE_PREFIX = "title: "

local function get_link(link)
  local home = os.getenv("HOME")
  local notes_dir = home .. "/" .. NOTES_DIR
  local relative_link = link:sub(#notes_dir + 1, -1)
  for line in io.lines(link) do
    if line:match(TITLE_PREFIX) then
      local title = line:sub(#TITLE_PREFIX + 1, -1)
      return string.format("{:$%s:}[%s]", relative_link, title)
    end
  end
  assert(false, "failed to find title in norg document")
end

local function insert_norg_link_at_cursor(entries, _config)
  if #entries ~= 1 then
    return -- only supports a single entry
  end
  local _row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- Insert first entry at cursor position
  local new_line = line:sub(1, col) .. get_link(entries[1]) .. line:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)
end

local function always_open(entries, _config)
  for _, entry in ipairs(entries) do
    local file = vim.fn.trim(entry)
    vim.cmd("edit " .. vim.fn.fnameescape(file))
  end
end

local function always_open_vsplit(entries, _config)
  for _, entry in ipairs(entries) do
    local file = vim.fn.trim(entry)
    vim.cmd("vsplit " .. vim.fn.fnameescape(file))
  end
end

tv.setup({
  window = {
    width = 0.8,
    height = 0.8,
    border = "none",
    title = " tv.nvim ",
    title_pos = "center",
  },
  channels = {
    files = {
      handlers = {
        ["<CR>"] = h.open_as_files,
        ["<C-o>"] = h.send_to_quickfix,
        ["<C-v>"] = h.open_in_vsplit,
      },
    },
    dirs = {
      handlers = {
        ["<CR>"] = always_open,
        ["<C-v>"] = always_open_vsplit,
      },
    },
    norg = {
      handlers = {
        ["<CR>"] = insert_norg_link_at_cursor,
      },
    },
    text = {
      handlers = {
        ["<CR>"] = h.open_at_line,
        ["<C-o>"] = h.send_to_quickfix,
        ["<C-v>"] = h.open_in_vsplit,
      },
    },
  },
  global_keybindings = {
    -- channels = "<leader>tv", -- opens the channel selector
  },
})
