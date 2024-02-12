local M = {}

-- ----------------------------------------------
-- Alternate File Switching
-- ----------------------------------------------
function M.alt(path)
	local function isempty(s)
		return s == nil or s == ''
	end

	local alternates = vim.fn.system("alt " .. path)
	-- check the exit status code to see if failure and return nil
	if isempty(alternates) then
		return nil
	else
		local alternates_table = {}
		for s in alternates:gmatch("[^\r\n]+") do
			table.insert(alternates_table, s)
		end
		return alternates_table
	end
end

function M.alt_command(path, alt_handler)
	local alternate_file_paths = M.alt(path)
	if alternate_file_paths == nil then
		print("No alternate files found for " .. path .. "!")
	else
		alt_handler(path, alternate_file_paths)
	end
end

return M
