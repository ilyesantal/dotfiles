local wk = require("which-key")
local trouble = require("trouble")

wk.register({
	["<leader>"] = {
		X= {
			name = "Diagnostics",
			x = { function() trouble.toggle() end, "Toggle" },
			w = { function() trouble.toggle("workspace_diagnostics") end, "Toggle Workspace diagnostics" },
			d = { function() trouble.toggle("document_diagnostics") end, "Toggle Document diagnostics" },
			q = { function() trouble.toggle("quickfix") end, "Toggle Quickfix" },
			l = { function() trouble.toggle("loclist") end, "Toggle Loclist" },
			r = { function() trouble.toggle("lsp_references") end, "Toggle LSP references" },
		}
	}, { mode = "n" }
})
