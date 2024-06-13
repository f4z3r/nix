local utils = require("lazy.utils")

local ls = require("luasnip")

vim.tbl_map(function(type)
  require("luasnip.loaders.from_" .. type).lazy_load()
end, { "vscode", "snipmate", "lua" })

ls.filetype_extend("typescript", { "tsdoc" })
ls.filetype_extend("javascript", { "jsdoc" })
ls.filetype_extend("lua", { "luadoc" })
ls.filetype_extend("python", { "pydoc" })
ls.filetype_extend("rust", { "rustdoc" })
ls.filetype_extend("cs", { "csharpdoc" })
ls.filetype_extend("java", { "javadoc" })
ls.filetype_extend("c", { "cdoc" })
ls.filetype_extend("cpp", { "cppdoc" })
ls.filetype_extend("php", { "phpdoc" })
ls.filetype_extend("kotlin", { "kdoc" })
ls.filetype_extend("ruby", { "rdoc" })
ls.filetype_extend("sh", { "shelldoc" })

vim.keymap.set({ "i" }, "<C-K>", function()
  ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  ls.jump(-1)
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
  ls.snippet({ trig = "fixes", name = "Fixes", desc = "Add fix trailer for GitHub issues" }, {
    ls.text_node("Fix #"),
    ls.insert_node(0),
  }),
  ls.snippet({ trig = "rel", name = "Relates-to", desc = "Add 'Relates-To' issue trailer" }, {
    ls.text_node("Relates-to: "),
    ls.insert_node(0),
  }),
  ls.snippet({ trig = "coa", name = "Co-authored-by", desc = "Add 'Co-authored-by' trailer" }, {
    ls.text_node("Co-authored-by: "),
    authors,
  }),
  ls.snippet({ trig = "ack", name = "Acked-by", desc = "Add 'Acked-by' trailer" }, {
    ls.text_node("Acked-by: "),
    authors,
  }),
  ls.snippet({ trig = "sign", name = "Signed-off-by", desc = "Add 'Signed-off-by' trailer" }, {
    ls.text_node("Signed-off-by: "),
    authors,
  }),
  ls.snippet({ trig = "help", name = "Helped-by", desc = "Add 'Helped-by' trailer" }, {
    ls.text_node("Helped-by: "),
    authors,
  }),
  ls.snippet({ trig = "ref", name = "Reference-to", desc = "Add 'Reference-to' commit trailer" }, {
    ls.text_node("Reference-to: "),
    commits,
  }),
  ls.snippet({ trig = "see", name = "See-also", desc = "Add 'See-also' commit trailer" }, {
    ls.text_node("See-also: "),
    commits,
  }),
})

-- automatically open choice select when entering such a node
vim.api.nvim_create_autocmd("User", {
  pattern = "LuasnipChoiceNodeEnter",
  callback = function()
    vim.schedule(function()
      require("luasnip.extras.select_choice")()
    end)
  end,
})
