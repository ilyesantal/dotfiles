local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local wk = require("which-key")

wk.register({
	["<leader>"] = {
		a = { mark.add_file, "Add file to Harpoon" }
	},
	["<C-e>"] = { ui.toggle_quick_menu, "Toggle Harpoon menu" },
	["<C-h>"] = { function() ui.nav_file(1) end, "Go to harpoon file #1" },
	["<C-t>"] = { function() ui.nav_file(2) end, "Go to harpoon file #2" },
	["<C-n>"] = { function() ui.nav_file(3) end, "Go to harpoon file #3" },
	["<C-s>"] = { function() ui.nav_file(4) end, "Go to harpoon file #4" },
}, { mode = "n" })
