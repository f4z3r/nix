local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")

harpoon:setup()
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

