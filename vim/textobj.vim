Plug 'michaeljsmith/vim-indent-object'

" text objects
Plug 'kana/vim-textobj-user'
" adds ic, ac, iC, and aC
Plug 'idbrii/textobj-word-column.vim'
" adds af, if for python functions and al, il for classes
Plug 'bps/vim-textobj-python'
    let g:textobj_python_no_default_key_mappings = 1
    xmap af <Plug>(textobj-python-function-a)
    omap af <Plug>(textobj-python-function-a)
    xmap if <Plug>(textobj-python-function-i)
    omap if <Plug>(textobj-python-function-i)
    xmap al <Plug>(textobj-python-class-a)
    omap al <Plug>(textobj-python-class-a)
    xmap il <Plug>(textobj-python-class-i)
    omap il <Plug>(textobj-python-class-i)
