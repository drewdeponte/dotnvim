return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'kyazdani42/nvim-web-devicons',
	},
	config = function()
		-- ----------------------------------------------
		-- Fuzzy Finder Configuration
		-- ----------------------------------------------
		vim.keymap.set('n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
		vim.keymap.set('n', '<leader>cs', '<cmd>lua require(\'telescope.builtin\').current_buffer_tags()<cr>')
		vim.keymap.set('n', '<leader>ct', '<cmd>lua require(\'telescope.builtin\').tags()<cr>')
		vim.keymap.set('n', '<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
		vim.keymap.set('n', '<leader>g', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
		vim.keymap.set('n', '<leader>j', '<cmd>lua require(\'telescope.builtin\').jumplist()<cr>')
		vim.keymap.set('n', '<leader>l', '<cmd>lua require(\'telescope.builtin\').loclist()<cr>')
		vim.keymap.set('n', '<leader>k', '<cmd>lua require(\'telescope.builtin\').keymaps()<cr>')
		vim.keymap.set('n', '<leader>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
	end
}
