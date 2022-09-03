-- ----------------------------------------------
-- AutoCommands
-- ----------------------------------------------
local file_type_group = vim.api.nvim_create_augroup('file_type_cmds', {clear=true})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	group = file_type_group,
	command = 'setlocal wrap linebreak nolist noexpandtab tabstop=4 shiftwidth=4 softtabstop=0 nosmarttab'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'tf', 'ts', 'html', 'rust', 'nroff', 'typescriptreact', 'dart', 'zsh' },
	group = file_type_group,
	command = 'setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=0 smarttab'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'javascript', 'htmldjango' },
	group = file_type_group,
	command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab'
})
