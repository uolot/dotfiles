" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'


" perform diffs on blocks of code
" https://github.com/AndrewRadev/linediff.vim
" :Linediff
" :LinediffReset
Plug 'AndrewRadev/linediff.vim'


" Lightning fast left-right movement in Vim
" https://github.com/unblevable/quick-scope
Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline


" Change an HTML(ish) opening tag and take the closing one along as well
" https://github.com/AndrewRadev/tagalong.vim
Plug 'AndrewRadev/tagalong.vim'


Plug 'jesseleite/vim-agriculture'
nmap <Leader>/ <Plug>AgRawSearch
vmap <Leader>/ <Plug>AgRawVisualSelection
nmap <Leader>* <Plug>AgRawWordUnderCurso
nnoremap <Leader>g* :AgRaw <C-r><C-a><CR>


" https://github.com/sainnhe/everforest
Plug 'sainnhe/everforest'

" Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is
" https://github.com/DanilaMihailov/beacon.nvim
Plug 'danilamihailov/beacon.nvim'
let g:beacon_shrink = 0
let g:beacon_timeout = 200
