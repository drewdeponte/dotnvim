-- ----------------------------------------------
-- Alternate File Switching
-- ----------------------------------------------
function alt(path)
	local function isempty(s)
		return s == nil or s == ''
	end

	local alternate = vim.fn.system("alt " .. path)
	if isempty(alternate) then
		return nil
	else
		return alternate
	end
end

function alt_command(path, alt_handler)
	local current_file_path = vim.fn.expand('%')
	local alternate_file_path = alt(current_file_path)
	if alternate_file_path == nil then
		print("No alternate file for " .. current_file_path .. " exists!")
	else
		alt_handler(current_file_path, alternate_file_path)
	end
end
