vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<space>", "<nop>")
vim.g.mapleader = " "

require("bindings.actions")
require("bindings.buffers")
require("bindings.comments")
require("bindings.diagnostics")
require("bindings.file")
require("bindings.general")
require("bindings.git")
require("bindings.jumplist")
require("bindings.locationlist")
require("bindings.neorg")
require("bindings.marks")
require("bindings.movement")
require("bindings.quicklist")
require("bindings.runner")
require("bindings.search")
require("bindings.switches")
require("bindings.toggles")
require("bindings.tests")
require("bindings.windows")
