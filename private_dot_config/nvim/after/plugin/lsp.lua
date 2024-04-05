local wk = require("which-key")
local lsp_zero = require("lsp-zero")

-- Inspect something
function _G.inspect(item)
	vim.print(item)
end

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'clangd',
		'pylsp',
		'bashls',
		'dockerls',
		'rust_analyzer',
		'tsserver'
	},
	handlers = {
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	},
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
	['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<Enter>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

cmp.setup({
	mapping = cmp_mappings
})

lsp_zero.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	wk.register({
		["<leader>"] = {
			l = {
				name = "LSP",
				w = {
					name = "Workspace",
					s = { function() vim.lsp.buf.workspace_symbol() end, "Symbol", opts },
					a = { function() vim.lsp.buf.add_workspace_folder() end, "Add", opts },
					r = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove", opts },
					l = { function() inspect(vim.lsp.buf.list_workspace_folders()) end, "List", opts },
				},
				o = {
					name = "Open",
					f = { function() vim.diagnostic.open_float() end, "Float", opts },
					k = { function() vim.lsp.buf.hover() end, "Hover", opts }
				},
				c = {
					name = "Code",
					a = { function() vim.lsp.buf.code_action() end, "Action", opts }
				},
				r = {
					r = { function() vim.lsp.buf.references() end, "References", opts },
					n = { function() vim.lsp.buf.rename() end, "Rename", opts }
				}
			}
		},
		g = {
			name = "Go to",
			d = { function() vim.lsp.buf.definition() end, "Definition", opts },
			n = { function() vim.diagnostic.goto_next() end, "Next", opts },
			p = { function() vim.diagnostic.goto_prev() end, "Previous", opts },
			r = { function() vim.lsp.buf.references() end, "References", opts },
		},
		K = { function() vim.lsp.buf.hover() end, "Hover", opts }
	}, { mode = "n" })
	-- wk.register({
	-- 	["<C-h>"] = { function() vim.lsp.buf.signature_help() end, opts }
	-- }, { mode = "i" })
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local float_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always", -- show source in diagnostic popup window
				prefix = " ",
			}

			if not vim.b.diagnostics_pos then
				vim.b.diagnostics_pos = { nil, nil }
			end

			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
				and #vim.diagnostic.get() > 0
			then
				vim.diagnostic.open_float(nil, float_opts)
			end

			vim.b.diagnostics_pos = cursor_pos
		end,
	})

	-- The blow command will highlight the current variable and its usages in the buffer.
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

		local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = gid,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.document_highlight()
			end
		})

		vim.api.nvim_create_autocmd("CursorMoved", {
			group = gid,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
			end
		})
	end

	if vim.g.logging_level == "debug" then
		local msg = string.format("Language server %s started!", client.name)
		vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
	end
end)

lsp_zero.configure("clangd", {
	cmd = {
		"cclangd", "swes_builder"
	}
})

local custom_attach = function(client, bufnr)
	-- -- Mappings.
	-- local map = function(mode, l, r, opts)
	-- 	opts = opts or {}
	-- 	opts.silent = true
	-- 	opts.buffer = bufnr
	-- 	keymap.set(mode, l, r, opts)
	-- end
	--
	-- map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
	-- map("n", "<C-]>", vim.lsp.buf.definition)
	-- map("n", "K", vim.lsp.buf.hover)
	-- map("n", "<C-k>", vim.lsp.buf.signature_help)
	-- map("n", "<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
	-- map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
	-- map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
	-- map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
	-- -- this puts diagnostics from opened files to quickfix
	-- map("n", "<space>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
	-- -- this puts diagnostics from current buffer to quickfix
	-- map("n", "<space>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
	-- map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
	-- map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
	-- map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
	-- map("n", "<space>wl", function()
	-- 	inspect(vim.lsp.buf.list_workspace_folders())
	-- end, { desc = "list workspace folder" })
	--
	-- -- Set some key bindings conditional on server capabilities
	-- if client.server_capabilities.documentFormattingProvider then
	-- 	map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
	-- end
	--
	-- api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local float_opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			border = "rounded",
	-- 			source = "always", -- show source in diagnostic popup window
	-- 			prefix = " ",
	-- 		}
	--
	-- 		if not vim.b.diagnostics_pos then
	-- 			vim.b.diagnostics_pos = { nil, nil }
	-- 		end
	--
	-- 		local cursor_pos = api.nvim_win_get_cursor(0)
	-- 		if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
	-- 			and #diagnostic.get() > 0
	-- 		then
	-- 			diagnostic.open_float(nil, float_opts)
	-- 		end
	--
	-- 		vim.b.diagnostics_pos = cursor_pos
	-- 	end,
	-- })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_zero.configure("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { 'W391' },
					maxLineLength = 100,
					-- formatter options
					black = { enabled = true },
					autopep8 = { enabled = false },
					yapf = { enabled = false },
					-- linter options
					pylint = { enabled = true, executable = "pylint" },
					pyflakes = { enabled = false },
					pycodestyle = { enabled = false },
					-- type checker
					pylsp_mypy = { enabled = true },
					-- auto-completion options
					jedi_completion = { fuzzy = true },
					-- import sorting
					pyls_isort = { enabled = true },

				}
			}
		}
	},
	flags = {
		debounce_text_changes = 200,
	},
	capabilities = capabilities,
})

lsp_zero.configure("tsserver", {})

require('lspconfig').tsserver.setup({
	single_file_support = false,
	on_attach = function(client, bufnr)
	end
})

lsp_zero.setup()

vim.diagnostic.config({
	virtual_text = true
})
