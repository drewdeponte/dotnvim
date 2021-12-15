" --------------------------------------------
" Configuration around Project rc files
" --------------------------------------------

" enable project specific .vimrc files
" set exrc

" ----------------------------------------------
" Line Numbering
" ----------------------------------------------
" Absolute line Numbering
" set number

" Relative Line Numbering
" set relativenumber

" Leave eol of source files alone
set nofixendofline

" Hybrid - Relative except for line currently on which shows absolute number
set number
set relativenumber

" Min number of characters to use for line number column
set numberwidth=5

" ----------------------------------------------
" Leader Key
" ----------------------------------------------
let mapleader = ","

" ----------------------------------------------
" NetRW - File Browser Mode
" ----------------------------------------------
" choose the tree view
" let g:netrw_liststyle = 0
" hide the default banner
" let g:netrw_banner = 0

" ----------------------------------------------
" Misc Preferences
" ----------------------------------------------

" allow backspacing over everything in insert mode
" set backspace=indent,eol,start

" disable auto folding when opening a buffer
" set nofoldenable

" show matching bracket when in insert mode
set showmatch

" keep abandoned unsaved buffers open in background
set hidden

" disable wrapping of text, just move editor over when cursor moves over
set nowrap

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Search
set nohlsearch
set incsearch
set ignorecase

" make it so when the cursor is within 8 lines of the edge of the screen it
" causes the scroll
set scrolloff=8

set colorcolumn=80

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" I like to use Ctrl-C for esc
imap <c-c> <esc>

" --------------------------------------------
" Plugins
" --------------------------------------------

" :PlugInstall - install
" :PlugUpdate - update or install
" :PlugStatus - status of plugins

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
" Fuzzy Finder (& interactive global search w/ ripgrep via :Rg)
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" Plug 'lotabout/skim.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Airline Status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Schemes
Plug 'drewtempelmeyer/palenight.vim'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Utilities
Plug 'tpope/vim-commentary' " make commenting code easier
Plug 'tpope/vim-surround' " make dealing with surroundings easier

" Global Search
" Normally I would also include the following. But skim provides interactive
" ripgrep support so I don't need the following plugin
" Plug 'jremmen/vim-ripgrep'

" Various Language Support

" Markdown
Plug 'plasticboy/vim-markdown' " support Markdown syntax

" Slack
Plug 'uptech/vim-slack-format'

" JavaScript
Plug 'pangloss/vim-javascript' " JavaScript support

" TypeScript
Plug 'leafgarland/typescript-vim' " TypeScript syntax

" Dart
Plug 'dart-lang/dart-vim-plugin' " Dart syntax

" GraphQL
Plug 'jparise/vim-graphql' " GrahpQL syntax in gql template strings

" Terraform
Plug 'hashivim/vim-terraform'

" React - JSX & TSX
" Plug 'mamellon/vim-jsx-typescript' " JSX syntax
Plug 'peitalin/vim-jsx-typescript' " TSX syntax

Plug 'jebberjeb/clojure-socketrepl.nvim'


" Completion
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }

" Plug 'Olical/conjure', {'tag': 'v4.23.0'}
" Plug 'tpope/vim-dispatch'
" Plug 'clojure-vim/vim-jack-in'
" " Only in Neovim:
" Plug 'radenling/vim-dispatch-neovim'

" Formatting Engine
Plug 'sbdchd/neoformat'

augroup fmt
  autocmd!
  autocmd BufWritePre *.ts Neoformat prettier
augroup END

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

Plug 'simrat39/rust-tools.nvim'

" Initialize plugin system
call plug#end()


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lu falsea vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'clojure_lsp', 'sourcekit', 'pyright', 'vimls', 'dockerls', 'terraformls', 'graphql' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

nvim_lsp.ccls.setup {
	init_options = {
		compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
	}
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
EOF

" Configure completion with cmp
lua <<EOF
	local cmp = require('cmp')

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    }
  })
EOF

lua <<EOF
	local function eslint_config_exists()
		local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

		if not vim.tbl_isempty(eslintrc) then
			return true
		end

		if vim.fn.filereadable("package.json") then
			if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
				return true
			end
		end

		return false
	end

	local lspconfig = require('lspconfig')

	local eslint = {
		lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
		lintStdin = true,
		lintFormats = {"%f:%l:%c: %m"},
		lintIgnoreExitCode = true,
		formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
		formatStdin = true
	}

	local function set_lsp_config(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 300)]]
		end
	end

	lspconfig.tsserver.setup {
		on_attach = function(client)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

			-- Enable completion triggered by <c-x><c-o>
			buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

			-- Mappings.
			local opts = { noremap=true, silent=true }

			-- See `:help vim.lsp.*` for documentation on any of the below functions
			buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
			buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
			buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
			buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
			buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
			buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
			buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
			buf_set_keymap('n', '<space>ca', '<cmd>lu falsea vim.lsp.buf.code_action()<CR>', opts)
			buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
			buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
			buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
			buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
			buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
			buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
			if client.config.flags then
				client.config.flags.allow_incremental_sync = true
			end
			client.resolved_capabilities.document_formatting = false
			set_lsp_config(client)
		end
	}

	lspconfig.efm.setup {
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = true
			client.resolved_capabilities.goto_definition = false
			set_lsp_config(client)
		end,
		root_dir = function()
			if not eslint_config_exists() then
				return nil
			end
			return vim.fn.getcwd()
		end,
		settings = {
			languages = {
				javascript = {eslint},
				javascriptreact = {eslint},
				["javascript.jsx"] = {eslint},
				typescript = {eslint},
				["typescript.tsx"] = {eslint},
				typescriptreact = {eslint}
			}
		},
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescript.tsx",
			"typescriptreact"
		},
	}

	require('rust-tools').setup({})
EOF



" Set fold to use treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" --------------------------------------------
" Color scheme
" --------------------------------------------
set background=dark
colorscheme palenight

" --------------------------------------------
" Airline Theme
" --------------------------------------------
let g:airline_theme='deus'

" ----------------------------------------------
" Fuzzy Finder Configuration
" ----------------------------------------------
" nnoremap <leader>f :Files<cr>
" nnoremap <leader>b :Buffers<cr>
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>

" ----------------------------------------------
" Alternate File Switching
" ----------------------------------------------
" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Find the alternate file for the current path and open it
nnoremap <leader>. :w<CR>:call AltCommand(expand('%'), ':e')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

nnoremap <leader>n :call RenameFile()<cr>

" ----------------------------------------------
" Markdown Support
" ----------------------------------------------

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation isn't good
let g:vim_markdown_conceal = 0

" support front matter of various formats
let g:vim_markdown_frontmatter = 1 " for YAML format
let g:vim_markdown_toml_frontmatter = 1 " for TOML format
let g:vim_markdown_json_frontmatter = 1 " for JSON format

" Open current buffer in Marked 2 for previewing
nnoremap <leader>mp :!open -a 'Marked 2' "%"<CR>

" --------------------------------------------
" Configuration around Tabs, Indentation, Etc.
" --------------------------------------------

" Explicitly tell vim to NOT replace tab characters with space characters. If
" we wanted to instead have space characters inserted instead of tab
" characters we would use set expandtab.
set noexpandtab

" The number of character spaces to visually represent a tab as. Note: This
" does NOT insert space characters in place of tab characters. It simply
" changes how tab characters visually appear.
set tabstop=2

" The number of character spaces the indention system should shift in or out.
" The indention system will try and use all tab characters if noexpandtab is
" set. If it can't it will use a combination of tab characters and space
" characters to reach the correct shift. Ex: lets say you have set noexpandtab
" shiftwidth=6 tabstop=4. shiftwidth isn't evenly divisible by 4 so it would
" use a tab character followed by 2 space characters. However, if you have set
" noexpandtab shiftwidth=6 tabstop=2 it would use 3 tab characters.
set shiftwidth=2

" Number of spaces that a <Tab> counts for while performing editing
"	operations, like inserting a <Tab> or using <BS>.
set softtabstop=0

" Always insert blanks according to the 'tabstop' or 'softtabstop'.
" 'shiftwidth' is only used for shifting text left or right.
set nosmarttab

" Enable soft word wrapping for markdown files. I do this because dealing with
" diffs of non-code (words) when they have hard line breaks is difficult in
" reviews. Having them be single long lines makes dealing with diffs much
" easier.
au FileType markdown setlocal wrap linebreak nolist

au FileType markdown setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0 nosmarttab
au FileType tf setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=0 smarttab
au FileType ts setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=0 smarttab
au FileType javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab
au FileType htmldjango setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab
au FileType html setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab
au FileType rust setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=0 smarttab textwidth=78
