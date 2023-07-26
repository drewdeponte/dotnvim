-- ----------------------------------------------
-- Alternate File Switching
-- ----------------------------------------------
function alt(path)
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

function alt_command(path, alt_handler)
  local alternate_file_paths = alt(path)
  if alternate_file_paths == nil then
    print("No alternate files found for " .. path .. "!")
  else
    alt_handler(path, alternate_file_paths)
  end
end

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

function alt_telescope_handler(current_file_path, alternate_file_paths)
  -- vim.cmd('w')
  -- vim.cmd('e ' .. alternate_file_path)
  alternates_picker(alternate_file_paths)
end

-- ----------------------------------------------
-- Personal Key Bindings
-- ----------------------------------------------

vim.keymap.set('n', '<leader>.', function()
  alt_command(vim.fn.expand('%'), alt_telescope_handler)
end)
