local splitjoin = require('mini.splitjoin')
local gen_hook = splitjoin.gen_hook

local brackets = {
  '%b{}',
  '%b[]',
  '%b()',
}

local add_comma = gen_hook.add_trailing_separator({ brackets = brackets })
local del_comma = gen_hook.del_trailing_separator({ brackets = brackets })

splitjoin.setup({
  split = { hooks_post = { add_comma } },
  join = { hooks_post = { del_comma } },
})
