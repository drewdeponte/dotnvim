-- ----------------------------------------------
-- TreeSitter
-- ----------------------------------------------
local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = { "ruby", "lua", "luadoc", "markdown", "markdown_inline", "rust", "toml", "kotlin", "sql", "swift", "yaml", "terraform", "typescript", "vim", "query", "bash", "css", "scss", "dart", "diff", "dockerfile", "git_rebase", "gitattributes", "gitignore", "graphql", "html", "javascript", "jsdoc", "json", "c" },
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = {
      "dart"
    }
  },
}

-- The following is here only because a performance regression was added to the parser at some point where dart indents are now super slow. So this is to lock it to a version prior to that.
-- see https://github.com/nvim-treesitter/nvim-treesitter/issues/4945 for details
-- local parser = require("nvim-treesitter.parsers").get_parser_configs()
-- parser.dart = {
--   install_info = {
--     url = "https://github.com/UserNobody14/tree-sitter-dart",
--     files = { "src/parser.c", "src/scanner.c" },
--     revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4", -- The last commit before the snail speed
--   },
-- }
