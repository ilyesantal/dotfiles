vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo = require("ufo")

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
local wk = require("which-key")
wk.register({
	z = {
		name = "Fold",
		R = { ufo.openAllFolds, "Open all folds" },
		M = { ufo.closeAllFolds, "Close all folds" }
	}
}, { mode = "n" })

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
