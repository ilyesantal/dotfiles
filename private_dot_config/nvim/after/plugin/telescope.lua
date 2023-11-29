local wk = require("which-key")
local builtin = require('telescope.builtin')

wk.register({
	["<leader>"] = {
		p = {
			name = "telescope",
			f = { builtin.find_files, "Find File" },
			g = { builtin.live_grep, "Live Grep" },
			w = { builtin.grep_string, "String Grep" },
			b = { builtin.buffers, "Buffers" },
			t = { builtin.git_files, "Git Files" },
			s = { function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") });
			end, "Grep" }
		}
	}
}, { mode = "n" })

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  }
}
