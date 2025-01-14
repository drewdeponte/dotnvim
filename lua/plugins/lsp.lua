return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			'hrsh7th/cmp-nvim-lsp',
			branch = 'main',
			dependencies = {
				{ 'hrsh7th/nvim-cmp', branch = 'main' }
			}
		},
	},
	config = function()
		local lspconfig = require('lspconfig')

		vim.diagnostic.config({ severity_sort = true })

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(_, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

			-- Enable completion triggered by <c-x><c-o>
			buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

			-- Mappings.
			local opts = { noremap = true, silent = true }

			-- See `:help vim.lsp.*` for documentation on any of the below functions
			buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>', opts)
			buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
			buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			buf_set_keymap('x', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
			buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
			buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
			buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
			buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)


			buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
			buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
			buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
				opts)
			buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
			buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

			-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
			-- nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
			-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
			-- nnoremap <silent> gT    <cmd>lua vim.lsp.buf.type_definition()<CR>
			-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
			-- nnoremap <silent> gs    <cmd>lua vim.lsp.buf.document_symbol()<CR>
			-- nnoremap <silent> gS    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
			-- nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
			-- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
		end

		-- Use a loop to conveniently call 'setup' on multiple servers and
		-- map buffer local keybindings when the language server attaches
		local servers = { 'clojure_lsp', 'pyright', 'vimls', 'dockerls', 'terraformls', 'graphql', 'dartls',
			'kotlin_language_server', 'jdtls' }
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup {
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
				capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			}
		end

		lspconfig.ruby_lsp.setup {
			on_attach = on_attach
		}

		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' }
					}
				}
			}
		}

		lspconfig.ts_ls.setup {}

		lspconfig.eslint.setup({
			settings = {
				format = false
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.ts" },
			command = "EslintFixAll",
		})


		lspconfig.ccls.setup {
			init_options = {
				compilationDatabaseDirectory = "build",
				index = {
					threads = 0,
				},
				clang = {
					excludeArgs = { "-frounding-math" },
				},
			}
		}

		lspconfig.ltex.setup {
			on_attach = on_attach,
			settings = {
				ltex = {
					language = "en-US",
					dictionary = { ['en-US'] = { "NotaCode", "Pullwalla", "Gumleaf", "Manuform", "qmk", "dottmux", "dotnvim", "Uptech", "drewdeponte", "Alacritty", "neovim", "mockist", "mockists", "Kinesis", "AppFit", "OpenSearch", "Faktory", "Firehose", "Deponte", "onDiem", "fvm" } },
					additionalRules = {
						languageModel = '~/ngrams/',
					}
				}
			}
		}

		vim.api.nvim_create_autocmd('BufWritePre', {
			pattern = '*',
			command = 'lua vim.lsp.buf.format()'
		})
	end
}
