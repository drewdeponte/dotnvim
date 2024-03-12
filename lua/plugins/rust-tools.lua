return {
	-- To enable more of the features of rust-analyzer, such as inlay hints and
	-- more
	'simrat39/rust-tools.nvim',
	lazy = true,
	ft = 'rust',
	config = function()
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

		require('rust-tools').setup {
			tools = { -- rust-tools options
				autoSetHints = true,
				-- hover_with_actions = true,
				inlay_hints = {
					show_parameter_hints = false,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
			-- all the opts to send to nvim-lspconfig
			-- these override the defaults set by rust-tools.nvim
			-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
			server = {
				-- on_attach is a callback called when the language server attachs to the buffer
				on_attach = on_attach,
				settings = {
					-- to enable rust-analyzer settings visit:
					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
					["rust-analyzer"] = {
						-- enable clippy on save
						checkOnSave = {
							command = "clippy"
						},
						procMacro = {
							enable = true
						},
					}
				}
			},
		}
	end
}
