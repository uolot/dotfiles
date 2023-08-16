-- " No need to set, already a default in NeoVim:
-- " set nocompatible
-- " set hidden " hide abandoned buffers
-- " set hlsearch " highlight search results
-- " set incsearch " go to first match when typing
-- " set laststatus=2 " show statusline for single buffer
-- " set wildmenu " enable filename completion

-- set completeopt=menu,menuone,noselect " show popup menu on completion with extra info
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- set completefunc=syntaxcomplete#Complete " set user-mode completions for <C-x><C-u>
vim.opt.completefunc = 'syntaxcomplete#Complete'
vim.opt.conceallevel = 2
-- set cursorline " highlight cursor line
vim.opt.cursorline = true
-- set expandtab " convert tabs to spaces
vim.opt.expandtab = true
-- set exrc " load local .nvimrc/.exrc files
vim.opt.exrc = true

-- " ufo
-- lua vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '' }
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- set foldcolumn=1
vim.o.foldcolumn = '1'
-- set foldlevel=99
vim.o.foldlevel = 99
-- set foldlevelstart=99
vim.o.foldlevelstart = 99
-- set foldenable
vim.o.foldenable = true
-- " ufo end

-- set formatoptions=cq1tj " formatting - :help fo-table
-- set formatoptions+=ln   " new options to test
-- set formatoptions-=r    " unsetting, for test
vim.o.formatoptions = 'cq1tjln'
-- set inccommand=split  " preview `:s` replace results
vim.o.inccommand = 'split'
-- set lazyredraw " do not redraw screen until needed
vim.o.lazyredraw = true
-- set linebreak " do not wrap in the middle of a word
vim.o.linebreak = true
-- set list " display special chars
vim.o.list = true
-- set listchars=tab:›\ ,trail:•
-- vim.o.listchars = { tab = '› ', trail = '•' }
vim.o.listchars = [[tab:›\ ,trail:•]]
-- set nomodelineexpr  " disable modelinexpr, see: https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
vim.o.modelineexpr = false
-- set number " display line numbers
vim.o.number = true
-- set omnifunc=syntaxcomplete#Complete " enable omnicompletion
vim.o.omnifunc = 'syntaxcomplete#Complete'
-- set relativenumber
vim.o.relativenumber = true
-- set scrolloff=3 " keep lines above/below cursor line
vim.o.scrolloff = 3
-- set shiftround " round the indent spacing to the next multiple of shiftwidth
vim.o.shiftround = true
-- set shiftwidth=0 " use tabstop number of tabs to indent
vim.o.shiftwidth = 0
-- set showbreak=↳ " mark wrapped lines
vim.o.showbreak = '↳'
-- set showcmd " show last command on bottom
vim.o.showcmd = true
-- set showmatch " highlight matching bracket
vim.o.showmatch = true
-- set splitbelow " open new horizontal splits below
vim.o.splitbelow = true
-- set splitright " open new vertical splits on the right
vim.o.splitright = true
-- set tabstop=2 " tab key inserts 4 spaces
vim.o.tabstop = 2
-- set title  " update terminal title
vim.o.title = true
vim.o.undofile = true
-- set updatetime=100
vim.o.updatetime = 100
-- set wildignorecase  " case-insensitive wild mode
vim.o.wildignorecase = true
-- set wildmode=list:longest,full
-- vim.o.wildmode = { 'list:longest', 'full' }
vim.o.wildmode = [[list:longest,full]]
-- set nowrap
vim.o.wrap = false
-- set nowrapscan " do not wrap to beginning of the file when searching
vim.o.wrapscan = false
