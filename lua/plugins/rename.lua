return {
	dir = 'rename',
	name = 'rename',
	dev = true,
	config = function()
		local r = require('rename')
		vim.keymap.set('n', '<leader>n', function()
			local old_name = vim.fn.expand('%')
			local new_name = vim.fn.input('New file name: ', vim.fn.expand('%'), 'file')
			r.rename(old_name, new_name)
		end)
	end
}
