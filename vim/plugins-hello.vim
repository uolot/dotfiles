" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'


" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <leader>nn :NERDTreeFocus<CR>
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'


" Add extra window movements with <C-w> g [hjkl]
" https://github.com/andymass/vim-tradewinds
Plug 'andymass/vim-tradewinds'


" highlight Python source code lines that lack test coverage
" https://github.com/mgedmin/coverage-highlight.vim
Plug 'mgedmin/coverage-highlight.vim'
" :HighlightCoverage


" pairs of handy bracket mappings
" https://github.com/tpope/vim-unimpaired
Plug 'tpope/vim-unimpaired'


" Generate Python docstring to your Python source code
" https://github.com/heavenshell/vim-pydocstring
" Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
let g:pydocstring_enable_mapping = 0
let g:pydocstring_formatter = 'google'
let g:pydocstring_doq_path = '/home/tomasz/.local/bin/doq'
let g:pydocstring_templates_path = '/home/tomasz/.dotfiles/doq'
nnoremap <Leader>pd :Pydocstring<CR>
xnoremap <Leader>pd :Pydocstring<CR>
nnoremap <Leader>pD :PydocstringFormat<CR>
