" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'


" Add extra window movements with <C-w> g [hjkl]
" https://github.com/andymass/vim-tradewinds
Plug 'andymass/vim-tradewinds'


" pairs of handy bracket mappings
" https://github.com/tpope/vim-unimpaired
Plug 'tpope/vim-unimpaired'

" use CTRL-A/CTRL-X to increment dates, times, and more
" https://github.com/llrt/vim-speeddating
Plug 'tpope/vim-speeddating'


" perform diffs on blocks of code
" https://github.com/AndrewRadev/linediff.vim
" :Linediff
" :LinediffReset
Plug 'AndrewRadev/linediff.vim'


" toggle zoom in / out individual windows (splits)
" https://github.com/dhruvasagar/vim-zoom
Plug 'dhruvasagar/vim-zoom'


" Lightning fast left-right movement in Vim
" https://github.com/unblevable/quick-scope
Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline


" Change an HTML(ish) opening tag and take the closing one along as well
" https://github.com/AndrewRadev/tagalong.vim
Plug 'AndrewRadev/tagalong.vim'
