-- ----------------------------------------------
-- TreeSitter
-- ----------------------------------------------
local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = { "c", "lua", "luadoc", "markdown", "markdown_inline", "rust", "toml", "sql", "swift", "yaml", "terraform", "typescript", "vim", "help", "query", "bash", "css", "scss", "dart", "diff", "dockerfile", "git_rebase", "gitattributes", "gitignore", "graphql", "html", "javascript", "jsdoc", "json" },
  highlight = { enable = true },
  indent = { enable = true },
}
