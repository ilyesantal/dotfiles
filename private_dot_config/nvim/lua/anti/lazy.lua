local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		dependencies = { { 'nvim-lua/plenary.nvim' } }
	},
	{
		'rose-pine/neovim', as = 'rose-pine'
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	'nvim-treesitter/playground',
	'theprimeagen/harpoon',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	'williamboman/mason.nvim',
	{
		"mistricky/codesnap.nvim", build = "make build_generator"
	},
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		}
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async'
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			opt = true
		}
	},
	{
		"folke/neodev.nvim",
		opts = {}
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	'nvim-tree/nvim-web-devicons',
	{
		'folke/trouble.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		}
	},
	'gelguy/wilder.nvim',
	'puremourning/vimspector',
	'tpope/vim-obsession',
	'xiyaowong/transparent.nvim',
	'kevinhwang91/rnvimr',
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter'
	}
})
