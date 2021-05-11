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

