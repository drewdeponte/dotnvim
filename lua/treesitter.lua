-- ----------------------------------------------
-- TreeSitter
-- ----------------------------------------------
local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = { "ruby", "lua", "luadoc", "markdown", "markdown_inline", "rust", "toml", "kotlin", "sql", "swift", "yaml", "terraform", "typescript", "vim", "query", "bash", "css", "scss", "dart", "diff", "dockerfile", "git_rebase", "gitattributes", "gitignore", "graphql", "html", "javascript", "jsdoc", "json", "c" },
  highlight = { enable = true },
  indent = { enable = true },
}
