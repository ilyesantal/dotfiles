local codesnap = require("codesnap")
local wk = require("which-key")

codesnap.setup({
	mac_window_bar = true,
	title = "CodeSnap.nvim",
	code_font_family = "CaskaydiaCove Nerd Font",
	watermark_font_family = "Pacifico",
	watermark = "",
	bg_theme = "bamboo",
	breadcrumbs_separator = "/",
	has_breadcrumbs = false,
})

wk.register({
	["<leader>"] = {
		C = {
			name = "Codesnap",
			s = { ":CodeSnap<CR>", "Codesnap" },
		}
	}
}, { mode = "v" })
