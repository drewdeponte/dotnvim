return {
	'plasticboy/vim-markdown',
	lazy = true,
	ft = 'markdown',
	config = function()
		-- ----------------------------------------------
		-- Markdown Support
		-- ----------------------------------------------

		-- disable header folding
		vim.g.vim_markdown_folding_disabled = 1

		-- do not use conceal feature, the implementation isn't good
		vim.g.vim_markdown_conceal = 0

		-- support front matter of various formats
		vim.g.vim_markdown_frontmatter = 1 -- for YAML format
		vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
		vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format
	end
}
