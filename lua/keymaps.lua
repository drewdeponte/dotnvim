-- I like to use Ctrl-C for esc when in insert mode
vim.keymap.set('i', '<c-c>', '<esc>')

-- ----------------------------------------------
-- Fuzzy Finder Configuration
-- ----------------------------------------------
vim.keymap.set('n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
vim.keymap.set('n', '<leader>g', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

-- ----------------------------------------------
-- Alt
-- ----------------------------------------------
function alt_handler(current_file_path, alternate_file_path)
	vim.cmd('w')
	vim.cmd('e ' .. alternate_file_path)
end

vim.keymap.set('n', '<leader>.', function()
		alt_command(vim.fn.expand('%'), alt_handler)
	end)

-- ----------------------------------------------
-- Rename Current File
-- ----------------------------------------------
vim.keymap.set('n', '<leader>n', function()
	local old_name = vim.fn.expand('%')
	local new_name = vim.fn.input('New file name: ', vim.fn.expand('%'), 'file')
	rename(old_name, new_name)
	end)

-- Open current buffer in Marked 2 for previewing
vim.keymap.set('n', '<leader>mp', '<cmd>!open -a \'Marked 2\' "%"<CR>')
