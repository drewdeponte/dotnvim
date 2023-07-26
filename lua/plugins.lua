-- --------------------------------------------
-- Plugins
-- --------------------------------------------

-- :PlugInstall - install
-- :PlugUpdate - update or install
-- :PlugStatus - status of plugins

local Plug = vim.fn['plug#']

-- Specify a directory for plugins
vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- Fuzzy Finder (& interactive global search w/ ripgrep via :Rg)
-- Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
-- Plug 'lotabout/skim.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- Airline Status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Color Schemes
Plug 'drewtempelmeyer/palenight.vim'

-- Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

-- Utilities
Plug 'tpope/vim-commentary' -- make commenting code easier
Plug 'tpope/vim-surround' -- make dealing with surroundings easier

-- Global Search
Plug 'jremmen/vim-ripgrep'

-- Various Language Support

-- Markdown
Plug 'plasticboy/vim-markdown' -- support Markdown syntax

-- Slack
Plug 'uptech/vim-slack-format'

-- JavaScript
Plug 'pangloss/vim-javascript' -- JavaScript support

-- TypeScript
Plug 'leafgarland/typescript-vim' -- TypeScript syntax

-- Dart
Plug 'dart-lang/dart-vim-plugin' -- Dart syntax

-- GraphQL
Plug 'jparise/vim-graphql' -- GrahpQL syntax in gql template strings

-- Terraform
Plug 'hashivim/vim-terraform'

-- React - JSX & TSX
-- Plug 'mamellon/vim-jsx-typescript' -- JSX syntax
Plug 'peitalin/vim-jsx-typescript' -- TSX syntax

-- Clojure - sockect repl
-- Plug 'jebberjeb/clojure-socketrepl.nvim'

-- Rust
Plug 'rust-lang/rust.vim'

-- Prisma - file detection and syntax highlighting
Plug 'pantharshit00/vim-prisma'

-- Plug 'Olical/conjure', {'tag': 'v4.23.0'}
-- Plug 'tpope/vim-dispatch'
-- Plug 'clojure-vim/vim-jack-in'
-- Only in Neovim:
-- Plug 'radenling/vim-dispatch-neovim'

Plug 'neovim/nvim-lspconfig'

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) -- We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'

-- Completion
Plug('hrsh7th/nvim-cmp', { branch = 'main' })
Plug('hrsh7th/cmp-nvim-lua', { branch = 'main' })
Plug('hrsh7th/cmp-nvim-lsp', { branch = 'main' })
Plug('hrsh7th/cmp-buffer', { branch = 'main' })
Plug('hrsh7th/cmp-path', { branch = 'main' })
Plug('hrsh7th/cmp-cmdline', { branch = 'main' })

Plug('onsails/lspkind.nvim')

Plug('L3MON4D3/LuaSnip', { branch = 'master' })
Plug('saadparwaiz1/cmp_luasnip')

-- Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'

-- To enable more of the features of rust-analyzer, such as inlay hints and
-- more
Plug 'simrat39/rust-tools.nvim'

-- Snippet engine

-- Formatting Engine
Plug 'sbdchd/neoformat'

Plug 'farmergreg/vim-lastplace'

Plug('joshdick/onedark.vim', { branch = 'main' })
Plug('sainnhe/sonokai', { branch = 'master' })

Plug('kevinhwang91/nvim-bqf')

Plug('vim-test/vim-test')

-- Initialize plugin system
vim.call('plug#end')

-- augroup fmt
--   autocmd!
--   autocmd BufWritePre *.ts Neoformat prettier
-- augroup END
