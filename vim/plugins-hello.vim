" One second to read GitHub code with vim
" https://github.com/drzel/vim-repo-edit
Plug 'drzel/vim-repo-edit'


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


Plug 'dense-analysis/ale'
let g:ale_linters = {
            \ 'python': ['mypy', 'flake8']
            \}
let g:ale_fixers = {
            \'python': ['black', 'isort']
            \}
let g:ale_fix_on_save = 1
nnoremap ]} :ALENext<CR>
nnoremap [{ :ALEPrevious<CR>
let g:ale_set_balloons = 1
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
