-- --------------------------------------------------------------------------
-- Leader Key
-- --------------------------------------------------------------------------
vim.g.mapleader = ","

-- --------------------------------------------------------------------------
-- Bootstrap lazy.nvim if it isn't installed
-- --------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- --------------------------------------------------------------------------
-- Setup lazy.nvim using the plugins directory for the lazy.nvim plugin specs
-- --------------------------------------------------------------------------
require("lazy").setup("plugins")

-- --------------------------------------------------------------------------
-- General Options, not tied to specific plugins
-- --------------------------------------------------------------------------

-- Leave eol of source files alone
vim.opt.fixendofline = true

-- Min number of characters to use for line number column
vim.opt.numberwidth = 5

-- show matching bracket when in insert mode
vim.opt.showmatch = true

-- keep abandoned unsaved buffers open in background
vim.opt.hidden = true

-- disable wrapping of text, just move editor over when cursor moves over
vim.opt.wrap = false

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 2

-- Search
-- set nohlsearch
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- make it so when the cursor is within 8 lines of the edge of the screen it
-- causes the scroll
vim.opt.scrolloff = 8

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
-- vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

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
vim.opt.expandtab = false

-- The number of character spaces to visually represent a tab as. Note: This
-- does NOT insert space characters in place of tab characters. It simply
-- changes how tab characters visually appear.
vim.opt.tabstop = 4

-- The number of character spaces the indention system should shift in or out.
-- The indention system will try and use all tab characters if noexpandtab is
-- set. If it can't it will use a combination of tab characters and space
-- characters to reach the correct shift. Ex: lets say you have set noexpandtab
-- shiftwidth=6 tabstop=4. shiftwidth isn't evenly divisible by 4 so it would
-- use a tab character followed by 2 space characters. However, if you have set
-- noexpandtab shiftwidth=6 tabstop=2 it would use 3 tab characters.
vim.opt.shiftwidth = 0

-- Number of spaces that a <Tab> counts for while performing editing
-- operations, like inserting a <Tab> or using <BS>.
vim.opt.softtabstop = 0

-- Always insert blanks according to the 'tabstop' or 'softtabstop'.
-- 'shiftwidth' is only used for shifting text left or right.
vim.opt.smarttab = false

-- ----------------------------------------------
-- Split Options
-- ----------------------------------------------

-- Make it so splits don't resize to be equal after closing a split
vim.opt.equalalways = false
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ----------------------------------------------
-- Line Numbering Options
-- ----------------------------------------------

-- Hybrid - Relative except for line currently on which shows absolute number
vim.opt.number = true
vim.opt.relativenumber = true

-- --------------------------------------------
-- Color scheme
-- --------------------------------------------
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd('colorscheme sonokai')

-- --------------------------------------------------------------------------
-- Keymaps
-- --------------------------------------------------------------------------

-- Open current buffer in Marked 2 for previewing
vim.keymap.set('n', '<leader>mp', '<cmd>!open -a \'Marked 2\' "%"<CR>')
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR><Esc>', { noremap = true, silent = true })

-- --------------------------------------------------------------------------
-- AutoCommands
-- --------------------------------------------------------------------------
local file_type_group = vim.api.nvim_create_augroup('file_type_cmds', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	group = file_type_group,
	command = 'setlocal wrap linebreak nolist noexpandtab tabstop=4 shiftwidth=4 softtabstop=0 nosmarttab'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'tf', 'ts', 'html', 'nroff', 'typescriptreact', 'dart', 'zsh', 'typescript', 'javascript', 'htmldjango', 'json', 'haskell', 'sh' },
	group = file_type_group,
	command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=0 smarttab'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'rust' },
	group = file_type_group,
	command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'kotlin', 'kt' },
	group = file_type_group,
	command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab'
})
