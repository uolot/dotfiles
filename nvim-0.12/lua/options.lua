vim.g.mapleader = ' '
vim.g.maplocalleader = '-'

local opt = vim.opt


-- Functional --------------------

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.exrc = true
opt.undofile = true -- Persistent undo
opt.timeoutlen = 500 -- Lower than default (1000) to quickly trigger which-key
opt.updatetime = 300 -- Faster completion


-- Editing --------------------

opt.backspace = "indent,eol,start" -- Better backspace behavior

-- indendation
-- opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 0
-- opt.softtabstop = 2
-- opt.smartindent = true
opt.tabstop = 2


-- Completion --------------------

-- TODO: try 'preview' instead of popup
opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noselect', 'popup' }
opt.completefunc = 'syntaxcomplete#Complete'


-- Display --------------------

opt.cmdheight = 1 -- Command line height
opt.cursorline = true
opt.wrap = false

-- numbers
opt.number = true
opt.relativenumber = true

-- windows and tabs
opt.splitbelow = true
opt.splitright = true
opt.title = true
opt.winborder = 'rounded'
opt.winblend = 0 -- Floating window transparency
opt.winminwidth = 10 -- Minimum window width

-- brackets
opt.matchtime = 2 -- how long to show matching bracket
opt.showmatch = true -- highlight matching bracket

-- scrolloff
opt.scrolloff = 3
opt.sidescrolloff = 10

-- popup menu
-- opt.pumheight = 10 -- Popup menu height
opt.pumblend = 5 -- Popup menu transparency

-- conceal
opt.conceallevel = 2
-- opt.concealcursor = "" -- Don't hide cursor line markup

-- Folding --------------------
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Search --------------------

-- opt.ignorecase = true
-- opt.smartcase = true


-- Colors --------------------

opt.termguicolors = true


-- Old config
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.formatoptions = 'cq1tjln'
-- vim.o.inccommand = 'split'
-- vim.o.lazyredraw = true
-- vim.o.linebreak = true
-- vim.o.list = true
-- vim.o.listchars = [[tab:›\ ,trail:•]]
-- vim.o.modelineexpr = false
-- vim.o.omnifunc = 'syntaxcomplete#Complete'
-- vim.o.shiftround = true
-- vim.o.showbreak = '↳'
-- vim.o.showcmd = true
-- vim.o.wildignorecase = true
-- vim.o.wildmode = [[list:longest,full]]
-- vim.o.wrapscan = false
