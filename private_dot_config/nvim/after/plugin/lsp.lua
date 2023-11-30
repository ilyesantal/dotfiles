local wk = require("which-key")
local lsp = require("lsp-zero")

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	  'clangd', 
	  'pylsp', 
	  -- 'bashls', 
	  'dockerls', 
	  -- 'rust_analyzer'
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
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
	mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	wk.register({
		["<leader>"] = {
			l = {
				name = "LSP",
				w = {
					name = "Workspace",
					s = { function() vim.lsp.buf.workspace_symbol() end, "Symbol", opts }
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
		},
		K = { function() vim.lsp.buf.hover() end, "Hover", opts }
	}, { mode = "n" })
	-- wk.register({
	-- 	["<C-h>"] = { function() vim.lsp.buf.signature_help() end, opts }
	-- }, { mode = "i" })
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.configure("clangd", {
        cmd = {
                "cclangd", "swes_builder"
        }
})

lsp.configure("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {'W391'},
					maxLineLength = 100
				}
			}
		}
	}
})


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

