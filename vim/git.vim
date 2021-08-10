Plug 'airblade/vim-gitgutter'
    let g:gitgutter_highlight_lines = 1
    " let g:gitgutter_map_keys = 0
    " <Leader>hp - preview hunk
    " <Leader>hs - stage hunk
    " <Leader>hu - unstage hunk
    nnoremap <Leader>hh :GitGutterLineHighlightsToggle<CR>
    nnoremap <Leader>ht :GitGutterToggle<CR>
    omap ih <Plug>(GitGutterTextObjectInnerPending)
    omap ah <Plug>(GitGutterTextObjectOuterPending)
    xmap ih <Plug>(GitGutterTextObjectInnerVisual)
    xmap ah <Plug>(GitGutterTextObjectOuterVisual)


Plug 'tpope/vim-fugitive'


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


" more pleasant editing on commit messages
" https://github.com/rhysd/committia.vim
Plug 'rhysd/committia.vim'


" One second to read GitHub code with vim
" https://github.com/drzel/vim-repo-edit
Plug 'drzel/vim-repo-edit'
