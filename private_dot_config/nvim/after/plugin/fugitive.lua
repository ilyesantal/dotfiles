vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
local wk = require("which-key")
wk.register({
	["<leader>"] = {
		name = "space",
		g = {
			name = "Fugitive",
			o = { vim.cmd.Git, "Git info" },
			b = { ":G blame<CR>", "Blame" },
			s = { ":G status<CR>", "Status" },
			d = { ":G diff<CR>", "Diff" },
			c = { ":G commit<CR>", "Commit" },
			p = { ":G push<CR>", "Push" },
			P = { ":G pull<CR>", "Pull" },
			f = { ":G fetch<CR>", "Fetch" },
			r = { ":G rebase<CR>", "Rebase" },
			R = { ":G reset<CR>", "Reset" },
			l = { ":G log<CR>", "Log" },
		}
	}, { mode = "n" }
})
