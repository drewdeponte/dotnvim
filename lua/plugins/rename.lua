return {
	dir = 'rename',
	name = 'rename',
	dev = true,
	config = function()
		local r = require('rename')
		vim.keymap.set('n', '<leader>n', function()
			r.rename_word_under_cursor()
		end)
	end
}
