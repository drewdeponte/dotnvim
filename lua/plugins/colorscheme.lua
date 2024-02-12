return {
	-- sainnhe/sonokai
	{
		'sainnhe/sonokai',
		branch = 'master',
		lazy = true,
		config = function()
			vim.g.sonokai_style = 'andromeda'
			vim.g.airline_theme = 'sonokai'
		end
	},

	-- joshdick/onedark.vim
	{
		'sainnhe/sonokai',
		branch = 'master',
		lazy = true,
	},

	-- drewtempelmeyer/palenight.vim
	{
		'drewtempelmeyer/palenight.vim',
		lazy = true,
	},

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "moon" },
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
	},
}
