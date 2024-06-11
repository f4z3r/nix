local utils = require("lazy.utils")

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i" }, "<C-K>", function()
  ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    require("luasnip.extras.select_choice")()
  end
end, { silent = true })

local function generate_dyn_choices(cmd)
  return ls.dynamic_node(1, function(_args, _parent, _old_state, _user_args)
    local authors = utils.run(cmd)
    local nodes = {}
    for _, author in ipairs(authors) do
      nodes[#nodes + 1] = ls.text_node(author)
    end
    return ls.snippet_node(nil, ls.choice_node(1, nodes))
  end)
end

local authors = generate_dyn_choices("bash -c 'git log --pretty=\"%an <%ae>\" | sort | uniq'")
local commits = generate_dyn_choices("bash -c 'git log --pretty=reference'")

ls.add_snippets("gitcommit", {
  ls.snippet("fixes", {
    ls.text_node("Fix #"),
    ls.insert_node(0),
  }),
  ls.snippet("rel", {
    ls.text_node("Relates-to: "),
    ls.insert_node(0),
  }),
  ls.snippet("coa", {
    ls.text_node("Co-authored-by: "),
    authors,
  }),
  ls.snippet("ack", {
    ls.text_node("Acked-by: "),
    authors,
  }),
  ls.snippet("sign", {
    ls.text_node("Signed-off-by: "),
    authors,
  }),
  ls.snippet("help", {
    ls.text_node("Helped-by: "),
    authors,
  }),
  ls.snippet("ref", {
    ls.text_node("Reference-to: "),
    commits,
  }),
  ls.snippet("see", {
    ls.text_node("See-also: "),
    commits,
  }),
})
