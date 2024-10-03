require("plugins")

vim.loader.enable()

require("config.lsp")
require("config.diagnostics")

--
-- custom highlights
--
vim.cmd([[highlight MatchArea guibg=#303030]])
vim.cmd([[hi! ColorColumn guifg=#adbac7 guibg=#2d3239]])

--
-- custom commands
--
vim.cmd([[command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis]])
-- reverse lines order
vim.cmd([[command -range Reverse <line1>,<line2>!tac]])

--
-- custom abbrevs
--
vim.cmd([[iabbrev <expr> YMD strftime("%Y-%m-%d")]])

require("mappings")
