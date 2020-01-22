" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
            \ ['&Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ['&Numbers %{&number? "Off":"On"}', 'set number!'],
            \ ['&Wrap %{&wrap? "Off":"On"}', 'set wrap!'],
            \ ['&Gitgutter lines highlight %{g:gitgutter_highlight_lines? "Off":"On"}', 'GitGutterLineHighlightsToggle'],
            \ ['&Cursor line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ])

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <space>. :call quickui#menu#open()<cr>
