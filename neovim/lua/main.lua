require('plugins.lazy')

require('impatient')
vim.loader.enable()

require('config.lsp')
require('config.diagnostics')

-- bg for hl_match_area
vim.cmd [[highlight MatchArea guibg=#303030]]

require('mappings')
