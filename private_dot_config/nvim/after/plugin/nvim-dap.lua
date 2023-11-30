local ndap = require('dap')
local wk = require('which-key')

wk.register({
	["<leader>"] = {
		b = { function() ndap.toggle_breakpoint() end, "Toggle breakpoint" },
		B = { function() ndap.set_breakpoint() end, "Set breakpoint" },
		l = {
			name = "Log point",
			p = { function() ndap.set_breakpoint(
				nil, nil, vim.fn.input('Log point message: '))
			end, "Set log point" }
		}
	},
	["<F5>"] = { function() ndap.continue() end, "Continue" },
	["<F10>"] = { function() ndap.step_over() end, "Step over" },
	["<F11>"] = { function() ndap.step_into() end, "Step into" },
	["<F12>"] = { function() ndap.step_out() end, "Step out" },
}, { mode = "n" })
