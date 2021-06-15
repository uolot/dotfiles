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
let g:traces_normal_preview = 1

" Close brackets on enter
" Config: https://github.com/rstacruz/vim-closer/blob/master/plugin/closer.vim
Plug 'rstacruz/vim-closer'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" isolate part of a file to create a 'safe edit environment'
Plug 'ferranpm/vim-isolate'

" Adds :Tabularize
Plug 'godlygeek/tabular'

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
                \ '1', '2', '3', '4', '5', '6', '9', '63', '75', '81', '85', '87',
                \ '99', '108', '115', '125', '137', '141', '142', '154',
                \ '159', '165', '167', '175', '202', '207', '208', '211', '214', '219',
                \ '226', '228'
                \ ]
    let g:interestingWordsRandomiseColors = 1

" Show keybindings in popup
" https://github.com/liuchengxu/vim-which-key
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>


" Distraction-free writing in Vim
" uninstall in June 2021
Plug 'junegunn/goyo.vim'
