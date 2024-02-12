local M = {}

function M.dec_slide_number(slide_number)
	if (tonumber(slide_number) <= 0)
	then
		return 0
	else
		return tonumber(slide_number) - 1
	end
end

function M.next_slide()
	local cur_buf_path = vim.api.nvim_buf_get_name(0)
	local cur_zero_padded_slide_number = string.match(cur_buf_path, '(%d+).md')
	local cur_slide_number = string.match(cur_buf_path, '0*(%d+).md')
	local next_slide_number = cur_slide_number + 1;
	local next_zero_padded_silde_number = string.format("%04d", next_slide_number)
	local next_slide_path = string.gsub(cur_buf_path, cur_zero_padded_slide_number, next_zero_padded_silde_number)
	return next_slide_path
end

function M.prev_slide()
	local cur_buf_path = vim.api.nvim_buf_get_name(0)
	local cur_zero_padded_slide_number = string.match(cur_buf_path, '(%d+).md')
	local cur_slide_number = string.match(cur_buf_path, '0*(%d+).md')
	local next_slide_number = M.dec_slide_number(cur_slide_number)
	local next_zero_padded_silde_number = string.format("%04d", next_slide_number)
	local next_slide_path = string.gsub(cur_buf_path, cur_zero_padded_slide_number, next_zero_padded_silde_number)
	return next_slide_path
end

function M.file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

return M
