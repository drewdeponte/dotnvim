-- ----------------------------------------------
-- Completion - completion with cmp
-- ----------------------------------------------

local cmp = require('cmp')
local lspkind = require('lspkind')

require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

require('copilot_cmp').setup()

cmp.setup({
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    }),
  },
  sources = {
    { name = 'copilot',  group_index = 3 },
    { name = 'nvim_lua', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip',  group_index = 2 },
    { name = 'path',     group_index = 2 },
    { name = 'buffer',   keyword_length = 5 },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        vsnip = "[snip]",
        copilot = "[copi]"
      }
    })
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
})
