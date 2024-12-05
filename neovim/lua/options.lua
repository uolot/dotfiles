-- " No need to set, already a default in NeoVim:
-- " set nocompatible
-- " set hidden " hide abandoned buffers
-- " set hlsearch " highlight search results
-- " set incsearch " go to first match when typing
-- " set laststatus=2 " show statusline for single buffer
-- " set wildmenu " enable filename completion

vim.g.mapleader = ' '
vim.g.maplocalleader = '-'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.completefunc = 'syntaxcomplete#Complete'
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.exrc = true

-- " ufo
-- lua vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '' }
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- " ufo end

vim.o.formatoptions = 'cq1tjln'
vim.o.inccommand = 'split'
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = [[tab:›\ ,trail:•]]
vim.o.modelineexpr = false
vim.o.number = true
vim.o.omnifunc = 'syntaxcomplete#Complete'
vim.o.relativenumber = true
vim.o.scrolloff = 3
vim.o.shiftround = true
vim.o.shiftwidth = 0
vim.o.showbreak = '↳'
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.title = true
vim.o.undofile = true
vim.o.updatetime = 100
vim.o.wildignorecase = true
-- vim.o.wildmode = { 'list:longest', 'full' }
vim.o.wildmode = [[list:longest,full]]
vim.o.wrap = false
vim.o.wrapscan = false
