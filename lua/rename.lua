local M = {}

function M.rename_word_under_cursor()
	local word = vim.fn.expand("<cword>")
	if word and word ~= "" then
		local cmd = string.format(":%%s/%s/", word)
		vim.api.nvim_feedkeys(cmd, "n", true)
		-- vim.cmd(cmd)
	else
		print("No word under cursor to rename!")
	end
end

return M
