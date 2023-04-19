---------- HELPERS ----------
local opt = vim.opt -- to set options
local g = vim.g -- a table to access global variables
local cmd = vim.cmd

-- Leave eol of source files alone
opt.fixendofline = false

-- --------------------------------------------
-- Color scheme
-- --------------------------------------------
opt.termguicolors = true
opt.background = 'dark'
g.sonokai_style = 'andromeda'
g.airline_theme = 'sonokai'
cmd('colorscheme sonokai')

-- ----------------------------------------------
-- Line Numbering
-- ----------------------------------------------

-- Hybrid - Relative except for line currently on which shows absolute number
opt.number = true
opt.relativenumber = true

-- Min number of characters to use for line number column
opt.numberwidth = 5

opt.splitright = true
opt.splitbelow = true

-- ----------------------------------------------
-- Leader Key
-- ----------------------------------------------
g.mapleader = ","

-- ----------------------------------------------
-- Misc Preferences
-- ----------------------------------------------

-- show matching bracket when in insert mode
opt.showmatch = true

-- keep abandoned unsaved buffers open in background
opt.hidden = true

-- disable wrapping of text, just move editor over when cursor moves over
opt.wrap = false

-- Some servers have issues with backup files, see #649.
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Give more space for displaying messages.
opt.cmdheight = 2

-- Search
-- set nohlsearch
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

-- make it so when the cursor is within 8 lines of the edge of the screen it
-- causes the scroll
opt.scrolloff = 8

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
-- vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = "yes"

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

-- Don't pass messages to |ins-completion-menu|.
-- set shortmess+=c

-- Avoid showing extra messages when using completion
-- set shortmess+=c

-- --------------------------------------------
-- Configuration around Tabs, Indentation, Etc.
-- --------------------------------------------

-- Explicitly tell vim to NOT replace tab characters with space characters. If
-- we wanted to instead have space characters inserted instead of tab
-- characters we would use set expandtab.
opt.expandtab = true

-- The number of character spaces to visually represent a tab as. Note: This
-- does NOT insert space characters in place of tab characters. It simply
-- changes how tab characters visually appear.
opt.tabstop = 2

-- The number of character spaces the indention system should shift in or out.
-- The indention system will try and use all tab characters if noexpandtab is
-- set. If it can't it will use a combination of tab characters and space
-- characters to reach the correct shift. Ex: lets say you have set noexpandtab
-- shiftwidth=6 tabstop=4. shiftwidth isn't evenly divisible by 4 so it would
-- use a tab character followed by 2 space characters. However, if you have set
-- noexpandtab shiftwidth=6 tabstop=2 it would use 3 tab characters.
opt.shiftwidth = 2

-- Number of spaces that a <Tab> counts for while performing editing
-- operations, like inserting a <Tab> or using <BS>.
opt.softtabstop = 0

-- Always insert blanks according to the 'tabstop' or 'softtabstop'.
-- 'shiftwidth' is only used for shifting text left or right.
opt.smarttab = true

-- ----------------------------------------------
-- Markdown Support
-- ----------------------------------------------

-- disable header folding
g.vim_markdown_folding_disabled = 1

-- do not use conceal feature, the implementation isn't good
g.vim_markdown_conceal = 0

-- support front matter of various formats
g.vim_markdown_frontmatter = 1 -- for YAML format
g.vim_markdown_toml_frontmatter = 1 -- for TOML format
g.vim_markdown_json_frontmatter = 1 -- for JSON format
