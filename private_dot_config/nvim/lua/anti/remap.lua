vim.g.mapleader = " "

local wk = require("which-key")

-- NORMAL MODE
wk.register({
	["<leader>"] = {
		e = {
			name = "Explore",
			f = { vim.cmd.Ex, "Files" }
		},
		y = { [["+y]], "Yank to system clipboard (e.g. ap for paragraph" },
		Y = { [["+Y]], "Yank line to system clipboard" },
		d = { [["_d]], "Into void" },
		f = { vim.lsp.buf.format, "Format buffer" },
	},
	["<C-d>"] = { "<C-d>zz", "Go down 1/2 page" },
	["<C-u>"] = { "<C-u>zz", "Go up 1/2 page" },
	J = { "mzJ`z", "Append line below without jumping" },
	n = { "nzzzv", "Go to next find" },
	N = { "Nzzzv", "Go to previous find" },
	Q = { "<nop>", "nop" },
	-- TODO -- not really working
	["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "tmux-sessionizer" },
}, { mode = "n" })

-- SELECT MODE
wk.register({
	["<leader>"] = {
		y = { [["+y]], "Yank to system clipboard (e.g. ap for paragraph" },
		d = { [["_d]], "Into void" },
	},
	J = { ":m '>+1<CR>gv=gv", "Move selection down" },
	K = { ":m '<-2<CR>gv=gv", "Move selection up" },
}, { mode = "v" })

-- VISUAL MODE
wk.register({
	["<leader>"] = {
		p = { [["_dP]], "yank to void and paste" },
	}
}, { mode = "x" })

-- INSERT MODE
wk.register({
	["<C-c>"] = { "<Esc>", "C-c === Esc" },
}, { mode = "i" })

-- TERMINAL MODE

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/anti/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
