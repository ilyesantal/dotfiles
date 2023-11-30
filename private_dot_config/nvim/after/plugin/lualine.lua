require('lualine').setup {
	options = {
		theme = 'seoul256'
	},
	selections = { lualine_c = { require('auto-session.lib').current_session_name } }
}
