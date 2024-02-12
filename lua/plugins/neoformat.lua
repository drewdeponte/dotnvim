return {
	'sbdchd/neoformat',
	lazy = true,
	ft = { 'typescript', 'javascript' },
	config = function()
		vim.g.neoformat_try_node_exe = 1

		local fmt_group = vim.api.nvim_create_augroup('fmt', { clear = true })
		vim.api.nvim_create_autocmd('BufWritePre', {
			pattern = { "*.ts", "*.js" },
			group = fmt_group,
			command = 'Neoformat prettier'
		})
	end
}
