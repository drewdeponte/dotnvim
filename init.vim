" --------------------------------------------
" Providers
" --------------------------------------------

let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

" --------------------------------------------
" Plugins
" --------------------------------------------

" :PlugInstall - install
" :PlugUpdate - update or install
" :PlugStatus - status of plugins

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'uptech/vim-slack-format'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Initialize plugin system
call plug#end()

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

au FileType markdown setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0 nosmarttab
au FileType tf setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=0 smarttab
au FileType javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab
au FileType htmldjango setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0 smarttab

" ----------------------------------------------
" Line Numbering
" ----------------------------------------------
" Absolute line Numbering
" set number

" Relative Line Numbering
" set relativenumber

" Hybrid - Relative except for line currently on which shows absolute number
set number
set relativenumber

" ----------------------------------------------
" Leader Key
" ----------------------------------------------

let mapleader = ","

" ----------------------------------------------
" Fuzzy Finding
" ----------------------------------------------

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

" Files & Buffers commands are provided by fzf
map <leader>f :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>

" ----------------------------------------------
" AutoCompletion
" ----------------------------------------------

let g:deoplete#enable_at_startup = 1

" ----------------------------------------------
" NetRW - File Browser Mode
" ----------------------------------------------

" choose the tree view
let g:netrw_liststyle = 3
" hide the default banner
let g:netrw_banner = 0

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
nnoremap <leader>. :w<cr>:call AltCommand(expand('%'), ':e')<cr>

" ----------------------------------------------
" Misc Preferences
" ----------------------------------------------

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" ----------------------------------------------
" TypeScript Support
" ----------------------------------------------

" mapping for get type of what cursor is on
nmap <leader>gt :TSType<CR>

" mapping for get definition of what cursor is on in a preview
nmap <leader>gd :TSDefPreview<CR>

autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript



