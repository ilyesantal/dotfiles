local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('AutoFormatting', {})

autocmd('BufWritePre', {
	pattern = '*.h,*.hpp,*.c,*.cpp',
	group = 'AutoFormatting',
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
