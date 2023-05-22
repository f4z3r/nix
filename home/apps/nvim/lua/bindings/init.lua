vim.g.maplocalleader = '\\'
vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = ' '

--require('actions.lua')
require('bindings.buffers')
--require('commands.lua')
--require('debug.lua')
--require('diagnostics.lua')
require('bindings.file')
require('bindings.general')
require('bindings.jumplist')
require('bindings.locationlist')
require('bindings.movement')
require('bindings.orgmode')
require('bindings.quicklist')
require('bindings.search')
--require('switches.lua')
--require('tests.lua')
require('bindings.windows')

