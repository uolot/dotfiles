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

" Open URI in browser
Plug 'tyru/open-browser.vim'
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)

" Highlight and navigate multiple words
" https://github.com/lfv89/vim-interestingwords
Plug 'lfv89/vim-interestingwords'
    let g:interestingWordsDefaultMappings = 0
    nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
    vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
    nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
    " let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
    let g:interestingWordsTermColors = [
                \ '1', '2', '3', '4', '5', '6', '9', '10', '12', '13', '14', '63', '75', '81', '85', '87',
                \ '89', '99', '108', '109', '115', '121', '125', '126', '137', '141', '142', '147', '154',
                \ '159', '165', '167', '175', '190', '202', '207', '208', '211', '214', '215', '219', '222',
                \ '223', '226', '228', '234'
                \ ]
    let g:interestingWordsRandomiseColors = 1

" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Wakatime
Plug 'wakatime/vim-wakatime'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
    nmap <Leader>tb :TagbarOpenAutoClose<CR>


" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'


" Show keybindings in popup
" https://github.com/liuchengxu/vim-which-key
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>
