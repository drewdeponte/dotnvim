-- ----------------------------------------------
-- Fuzzy Finder Configuration
-- ----------------------------------------------
vim.keymap.set('n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
vim.keymap.set('n', '<leader>g', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

function dec_slide_number(slide_number)
  if (tonumber(slide_number) <= 0)
  then
    return 0
  else
    return tonumber(slide_number) - 1
  end
end

function next_slide()
  local cur_buf_path = vim.api.nvim_buf_get_name(0)
  local cur_zero_padded_slide_number = string.match(cur_buf_path, '(%d+).md')
  local cur_slide_number = string.match(cur_buf_path, '0*(%d+).md')
  local next_slide_number = cur_slide_number + 1;
  local next_zero_padded_silde_number = string.format("%04d", next_slide_number)
  local next_slide_path = string.gsub(cur_buf_path, cur_zero_padded_slide_number, next_zero_padded_silde_number)
  return next_slide_path
end

function prev_slide()
  local cur_buf_path = vim.api.nvim_buf_get_name(0)
  local cur_zero_padded_slide_number = string.match(cur_buf_path, '(%d+).md')
  local cur_slide_number = string.match(cur_buf_path, '0*(%d+).md')
  local next_slide_number = dec_slide_number(cur_slide_number)
  local next_zero_padded_silde_number = string.format("%04d", next_slide_number)
  local next_slide_path = string.gsub(cur_buf_path, cur_zero_padded_slide_number, next_zero_padded_silde_number)
  return next_slide_path
end

function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

vim.keymap.set('n', '<right>', function()
  if (file_exists(next_slide()))
  then
    vim.cmd(':e ' .. next_slide())
  end
end)

vim.keymap.set('n', '<left>', function()
  if (file_exists(prev_slide()))
  then
    vim.cmd(':e ' .. prev_slide())
  end
end)

-- ----------------------------------------------
-- Rename Current File
-- ----------------------------------------------
vim.keymap.set('n', '<leader>n', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', vim.fn.expand('%'), 'file')
  rename(old_name, new_name)
end)

-- Open current buffer in Marked 2 for previewing
vim.keymap.set('n', '<leader>mp', '<cmd>!open -a \'Marked 2\' "%"<CR>')
