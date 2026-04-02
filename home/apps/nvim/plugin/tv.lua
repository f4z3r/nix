local tv = require("tv")

local h = tv.handlers

local TITLE_PREFIX = "title: "

local function strip_todo_prefix(heading)
  return heading:gsub(" %(.%) ", " ")
end

local function strip_heading_prefix(heading)
  return heading:gsub("%*+ ", "")
end

local function get_file_and_line_from_entries(entries)
  assert(#entries == 1, "this operation only support single entries")

  local parts = vim.split(entries[1], ":", { plain = true })
  local filename = vim.fn.trim(parts[1])
  if #parts < 2 then
    return filename, nil
  end
  assert(vim.fn.filereadable(filename) == 1, "file is not readable: " .. filename)
  local lnum = tonumber(vim.fn.trim(parts[2])) or 1
  return filename, lnum
end

local function read_line(file_path, line_number)
  local file = assert(io.open(file_path, "r"), "failed to open file: " .. file_path)
  local curr = 1
  for line in file:lines() do
    if curr == line_number then
      file:close()
      return line
    end
    curr = curr + 1
    if curr > line_number then
      file:close()
      assert(false, "failed to find line in file")
    end
  end
  file:close()
  assert(false, "failed to find line in file")
end

local function get_link(link, heading)
  -- need to add trailing slash for neorg
  local absolute_link = "/" .. link:gsub("%./", "")
  if heading then
    heading = strip_todo_prefix(heading)
    return string.format("{:$%s:%s}[%s]", absolute_link, heading, strip_heading_prefix(heading))
  else
    for line in io.lines(link) do
      if line:match(TITLE_PREFIX) then
        local title = line:sub(#TITLE_PREFIX + 1, -1)
        return string.format("{:$%s:}[%s]", absolute_link, title)
      end
    end
  end
  assert(false, "failed to find title in norg document")
end

local function insert_norg_link_at_cursor(entries, _config)
  local filename, lnum = get_file_and_line_from_entries(entries)

  local _row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local heading
  if lnum ~= nil then
    heading = read_line(filename, lnum)
  end
  local link = get_link(filename, heading)

  -- Insert first entry at cursor position
  local new_line = line:sub(1, col) .. link .. line:sub(col + 1)
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
  quickfix = {
    auto_open = false,
  },
})
