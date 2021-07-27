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


" https://github.com/dense-analysis/ale
Plug 'dense-analysis/ale'
let g:ale_linters = {
            \ 'python': ['mypy', 'flake8', 'pylint']
            \}
let g:ale_fixers = {
            \'bash': ['shfmt'],
            \'python': ['black', 'isort'],
            \'sh': ['shfmt'],
            \}
let g:ale_fix_on_save = 1
let g:ale_python_pylint_use_global = 0
nnoremap ]} :ALENext<CR>
nnoremap [{ :ALEPrevious<CR>
nnoremap <Leader>at :ALEToggleBuffer<CR>
nnoremap <Leader>aT :ALEToggle<CR>
nnoremap <Leader>al :ALELint<CR>
nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>aa :lopen<CR>
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


" GitHub extension for fugitive.vim
" https://github.com/tpope/vim-rhubarb
Plug 'tpope/vim-rhubarb'

" extension to fugitive.vim for gitlab support
" https://github.com/shumphrey/fugitive-gitlab.vim
Plug 'shumphrey/fugitive-gitlab.vim'

" Add Bitbucket URL support to fugitive.vim's :Gbrowse command
" https://github.com/tommcdo/vim-fubitive
Plug 'tommcdo/vim-fubitive'

" A git commit browser in Vim
" https://github.com/junegunn/gv.vim
Plug 'junegunn/gv.vim'
