return {
	'vim-test/vim-test',
	config = function ()
		vim.g['test#strategy'] = 'neovim'
		vim.g['test#neovim#term_position'] = 'vert'
		-- vim.g['test#custom_runners'] = { dart = { 'vgvtest' } }

		vim.keymap.set('n', '<leader>t', '<cmd>:TestNearest<CR>', { silent = true })
		vim.keymap.set('n', '<leader>T', '<cmd>:TestFile<CR>', { silent = true })
		vim.keymap.set('n', '<leader>a', '<cmd>:TestSuite<CR>', { silent = true })
		vim.keymap.set('n', '<leader>l', '<cmd>:TestLast<CR>', { silent = true })
		vim.keymap.set('n', '<leader>v', '<cmd>:TestVisit<CR>', { silent = true })
	end
}
