-- ----------------------------------------------
-- Rename Current File
-- ----------------------------------------------
function rename(old_name, new_name)
	if new_name ~= '' and new_name ~= old_name then
		vim.cmd('saveas ' .. new_name)
		vim.cmd('silent !rm ' .. old_name)
	end
end
