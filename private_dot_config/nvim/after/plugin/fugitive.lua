vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
local wk = require("which-key")
wk.register({
	["<leader>"] = {
		name = "space",
		g = {
			name = "Fugitive",
			o = { vim.cmd.Git , "Git info" },
		}
	}, { mode = "n" }
})
