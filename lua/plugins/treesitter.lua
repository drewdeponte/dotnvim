return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/playground',
		'nvim-treesitter/nvim-treesitter-context'
	},
	version = false,
	build = ':TSUpdate',
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "luadoc", "vim", "vimdoc", "query", "ruby", "markdown", "markdown_inline", "rust", "toml", "kotlin", "sql", "yaml", "terraform", "typescript", "javascript", "jsdoc", "json", "query", "bash", "css", "scss", "dart", "diff", "dockerfile", "git_rebase", "gitattributes", "gitignore", "graphql", "html", "elixir", "heex" },
			highlight = { enable = true },
			indent = { enable = true, disable = { "dart" } },
		})
	end
}
