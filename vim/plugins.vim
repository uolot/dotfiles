" highlight yanked region
Plug 'machakann/vim-highlightedyank'

" underline word under cursor
Plug 'itchyny/vim-cursorword'
    let g:cursorword_highlight = 0
    " NOTE: colors for CursorWord0 and CursorWord1 are defined in uolors.vim

" Readline style insertion
Plug 'tpope/vim-rsi'

" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'romainl/vim-cool'

" Range, pattern and substitute preview
Plug 'markonm/traces.vim'

" Close brackets on enter
" Config: https://github.com/rstacruz/vim-closer/blob/master/plugin/closer.vim
Plug 'rstacruz/vim-closer'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" isolate part of a file to create a 'safe edit environment'
Plug 'ferranpm/vim-isolate'

" Adds :Tabularize
Plug 'godlygeek/tabular'

" search local vimrc files (".lvimrc") in the tree  and load them
Plug 'embear/vim-localvimrc'
    let g:localvimrc_persistent = 2
    let g:localvimrc_sandbox = 0
