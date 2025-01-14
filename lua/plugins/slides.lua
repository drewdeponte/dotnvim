return {
	dir = vim.fn.stdpath("config") .. "/lua/slides",
	name = 'slides',
	dev = true,
	config = function()
		local s = require 'slides'

		vim.keymap.set('n', '<right>', function()
			if (s.file_exists(s.next_slide()))
			then
				vim.cmd(':e ' .. s.next_slide())
			end
		end)

		vim.keymap.set('n', '<left>', function()
			if (s.file_exists(s.prev_slide()))
			then
				vim.cmd(':e ' .. s.prev_slide())
			end
		end)
	end
}
