local splitjoin = require("mini.splitjoin")
local gen_hook = splitjoin.gen_hook

local curly = { "%b{}" }

local add_comma = gen_hook.add_trailing_separator()
local del_comma = gen_hook.del_trailing_separator()
local pad_curly = gen_hook.pad_brackets({ brackets = curly })

splitjoin.setup({
  split = { hooks_post = { add_comma } },
  join = { hooks_post = { del_comma, pad_curly } },
})
