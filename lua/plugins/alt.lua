return {
	dir = vim.fn.stdpath("config") .. "/lua/alt",
	name = 'alt',
	dev = true,
	dependencies = {
		'nvim-telescope/telescope.nvim'
	},
	config = function()
		local a = require('alt')

		-- ----------------------------------------------
		-- Telescope Selection of Alternates
		-- ----------------------------------------------

		local pickers = require "telescope.pickers"
		local finders = require "telescope.finders"
		local sorters = require "telescope.sorters"

		local alternates_picker = function(alternates, opts)
			opts = opts or {}
			pickers.new(opts, {
				prompt_title = "alternates",
				finder = finders.new_table {
					results = alternates
				},
				sorter = sorters.fuzzy_with_index_bias(opts),
			}):find()
		end

		local function alt_telescope_handler(_current_file_path, alternate_file_paths)
			-- vim.cmd('w')
			-- vim.cmd('e ' .. alternate_file_path)
			alternates_picker(alternate_file_paths)
		end

		-- ----------------------------------------------
		-- Personal Key Bindings
		-- ----------------------------------------------

		vim.keymap.set('n', '<leader>.', function()
			a.alt_command(vim.fn.expand('%'), alt_telescope_handler)
		end)
	end
}
