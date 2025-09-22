return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/playground',
		'nvim-treesitter/nvim-treesitter-textobjects',
		-- 'nvim-treesitter/nvim-treesitter-context'
	},
	version = false,
	build = ':TSUpdate',
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "luadoc", "vim", "vimdoc", "query", "ruby", "markdown", "markdown_inline", "rust", "toml", "kotlin", "sql", "yaml", "terraform", "typescript", "javascript", "jsdoc", "json", "query", "bash", "css", "scss", "dart", "diff", "dockerfile", "git_rebase", "gitattributes", "gitignore", "graphql", "html", "elixir", "heex" },
			highlight = { enable = true },
			indent = { enable = true, disable = { "dart" } },
			textobjects = {
				move = {
					enable = true,
					-- set_jumps = true, -- record jumps in jumplist
					goto_next_start = {
					  ["]m"] = { query = "@function.outer", desc = "Next function/method start" },
					  ["]]"] = { query = "@class.outer", desc = "Next class start" },
					},
					goto_next_end = {
					  ["]M"] = { query = "@function.outer", desc = "Next function/method end" },
					  ["]["] = { query = "@class.outer", desc = "Next class end" },
					},
					goto_previous_start = {
					  ["[m"] = { query = "@function.outer", desc = "Prev function/method start" },
					  ["[["] = { query = "@class.outer", desc = "Prev class start" },
					},
					goto_previous_end = {
					  ["[M"] = { query = "@function.outer", desc = "Prev function/method end" },
					  ["[]"] = { query = "@class.outer", desc = "Prev class end" },
					},
				}
			}
		})
	end
}
