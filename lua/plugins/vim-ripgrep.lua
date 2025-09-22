return {
	'jremmen/vim-ripgrep',
	config = function()
		vim.keymap.set("n", "<leader>gar", function()
				local word = vim.fn.expand("<cword>")
				if word and word ~= "" then
					local cmd = string.format("Rg '\\b%s\\b'", word)
					vim.fn.histadd("cmd", cmd)
					vim.cmd(cmd)
				else
					print("No word under cursor to search!")
				end
			end,
			{ noremap = true, silent = true }
		)

		vim.keymap.set("n", "<leader>gr", function()
				local word = vim.fn.expand("<cword>")
				if word and word ~= "" then
					local cmd = string.format("Rg '\\b%s\\b' --glob \"!*_spec.rb\"", word)
					vim.fn.histadd("cmd", cmd)
					vim.cmd(cmd)
				else
					print("No word under cursor to search!")
				end
			end,
			{ noremap = true, silent = true }
		)
	end
}
