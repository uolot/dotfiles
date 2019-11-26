" ------ General settings ------

set nocompatible

syntax on
filetype on " enables filetype detection
filetype plugin on " enables filetype specific plugins
let mapleader=" "

set backspace=indent,eol,start
set completeopt=menu,preview " show popup menu on completion with extra info
set completefunc=syntaxcomplete#Complete " set user-mode completions for <C-x><C-u>
set cursorline " highlight cursor line
set expandtab " convert tabs to spaces
set formatoptions=cq1tj " formatting
set incsearch " go to first match when typing
set laststatus=2 " show statusline for single buffer
set lazyredraw " do not redraw screen until needed
set list " display special chars
set listchars=tab:→\ ,trail:∎ " special chars for list mode
set nomodelineexpr  " disable modelinexpr, see: https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set mouse= " disable mouse
set number " display line numbers
set omnifunc=syntaxcomplete#Complete " enable omnicompletion
set scrolloff=6 " keep 6 lines above/below cursor line
set shiftwidth=0 " use tabstop number of tabs to indent
set showbreak=↪ " mark wrapped lines
set showcmd " show last command on bottom
set showmatch " highlight matching bracket
set splitbelow " open new horizontal splits below
set splitright " open new vertical splits on the right
set tabstop=4 " tab key inserts 4 spaces
set wildmenu " enable filename completion
set wildmode=list:longest,full


" ------ Plugins ------

" install plug.vim
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" highlight yanked region
Plug 'machakann/vim-highlightedyank'

" Readline style insertion
Plug 'tpope/vim-rsi'

" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'romainl/vim-cool'

" Range, pattern and substitute preview
Plug 'markonm/traces.vim'

source $HOME/.dotfiles/vim/lang-python.vim

call plug#end()

filetype plugin indent on


" ------ Colors ------

source $HOME/.dotfiles/vim/uolors.vim


" ------ Status line ------

source $HOME/.dotfiles/vim/statusline.vim


" ------ Mappings ------

" jump between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" switch between buffers
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" insert blank lines
nnoremap gO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap go  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

