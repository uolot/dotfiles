" search local vimrc files (".lvimrc") in the tree  and load them
" uninstall in June 2021
Plug 'embear/vim-localvimrc'
    let g:localvimrc_persistent = 2
    let g:localvimrc_sandbox = 0


" Vim plugin that displays tags in a window, ordered by scope
" uninstall in June 2021
Plug 'majutsushi/tagbar'
    nmap <Leader>tb :TagbarOpenAutoClose<CR>


" The interactive scratchpad for hackers
" https://github.com/metakirby5/codi.vim
" uninstall in July 2021
Plug 'metakirby5/codi.vim'

