local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

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
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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
local servers = { 'tsserver', 'clojure_lsp', 'sourcekit', 'pyright', 'vimls', 'dockerls', 'terraformls', 'graphql',
  'dartls', 'lua_ls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

local rust_opts = {
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
      }
    }
  },
}

require('rust-tools').setup(rust_opts)

nvim_lsp.ccls.setup {
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

nvim_lsp.ltex.setup {
  on_attach = on_attach,
  settings = {
    ltex = {
      additionalRules = {
        languageModel = '~/ngrams/',
      }
    }
  }
}

-- Configure JavaScript/TypeScript, etc.
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
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function set_lsp_config(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 300)]]
  end
end

require('trouble').setup {
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = false, -- use devicons for filenames
  -- mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  group = true, -- group results by file
  padding = true, -- add an extra new line on top of the list
  action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = { "o" }, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "O", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- previous item
    next = "j" -- next item
  },
  indent_lines = false, -- add an indent guide below the fold icons
  auto_open = true, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info",
    other = "other"
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  { silent = true, noremap = true }
)
