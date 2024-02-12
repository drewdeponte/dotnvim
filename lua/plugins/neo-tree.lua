return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
	-- keys = {
	-- 	{ "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	-- },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("neo-tree").setup()
	end,
}
