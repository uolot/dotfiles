" :so $VIMRUNTIME/syntax/hitest.vim

syntax reset
set background=dark

" template
"highlight Normal ctermfg=x ctermbg=x cterm=x

highlight Normal ctermfg=250 ctermbg=236 cterm=NONE
highlight StatusLine ctermfg=236 ctermbg=248 cterm=NONE
highlight StatusLineNC ctermfg=236 ctermbg=240 cterm=NONE

highlight Comment ctermfg=245 ctermbg=NONE cterm=italic
highlight Todo ctermfg=202 ctermbg=NONE cterm=NONE
highlight Underlined ctermfg=81 term=NONE cterm=NONE


highlight CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
highlight CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE

highlight LineNr ctermfg=239 ctermbg=NONE cterm=NONE
highlight CursorLineNr ctermfg=247 ctermbg=238 cterm=NONE

highlight Statement ctermfg=255 ctermbg=NONE cterm=NONE
highlight Conditional ctermfg=255 ctermbg=NONE cterm=NONE
highlight Function ctermfg=255 ctermbg=NONE cterm=NONE
highlight Identifier ctermfg=255 ctermbg=NONE cterm=NONE
highlight Keyword ctermfg=255 ctermbg=NONE cterm=NONE
highlight PreProc ctermfg=255 ctermbg=NONE cterm=NONE
highlight Include ctermfg=255 ctermbg=NONE cterm=NONE
highlight Define ctermfg=255 ctermbg=NONE cterm=NONE
highlight Operator ctermfg=255 ctermbg=NONE cterm=NONE
highlight pythonOperator ctermfg=255 ctermbg=NONE cterm=NONE

highlight Type ctermfg=230 ctermbg=NONE cterm=NONE
highlight Constant ctermfg=230 ctermbg=NONE cterm=NONE

highlight String ctermfg=194 ctermbg=NONE cterm=NONE
highlight Character ctermfg=194 ctermbg=NONE cterm=NONE

highlight Special ctermfg=214 ctermbg=NONE cterm=NONE
highlight Number ctermfg=225 ctermbg=NONE cterm=NONE

highlight Boolean ctermfg=255 ctermbg=NONE cterm=NONE

highlight Visual ctermfg=232 ctermbg=76 cterm=NONE
highlight ColorColumn ctermfg=238 ctermbg=NONE cterm=underline
highlight Search ctermfg=232 ctermbg=220 cterm=NONE
highlight MatchParen ctermfg=178 ctermbg=239 cterm=NONE

highlight Folded ctermfg=242 ctermbg=NONE cterm=italic

highlight Error ctermfg=196 ctermbg=NONE cterm=NONE

highlight Pmenu ctermfg=244 ctermbg=0 cterm=NONE
highlight PmenuSel ctermfg=255 ctermbg=240 cterm=NONE

" tabline bg
highlight TabLineFill ctermfg=250 ctermbg=236 cterm=NONE
" tabline non-active tab
highlight TabLine ctermfg=236 ctermbg=240 cterm=NONE
" tabline active tab
highlight TabLineSel ctermfg=236 ctermbg=248 cterm=None

highlight pythonDefOrClass ctermfg=215 ctermbg=NONE cterm=italic

highlight DiffAdd ctermfg=82 ctermbg=NONE cterm=NONE
highlight DiffChange ctermfg=202 ctermbg=NONE cterm=NONE
highlight DiffDelete ctermfg=196 ctermbg=NONE cterm=NONE

highlight diffAdded ctermfg=82 ctermbg=NONE cterm=NONE
highlight diffChanged ctermfg=202 ctermbg=NONE cterm=NONE
highlight diffRemoved ctermfg=196 ctermbg=NONE cterm=NONE

highlight GitGutterAddDefault ctermfg=82 ctermbg=NONE cterm=NONE
highlight GitGutterChangeDefault ctermfg=202 ctermbg=NONE cterm=NONE
highlight GitGutterDeleteDefault ctermfg=196 ctermbg=NONE cterm=NONE

highlight CursorWord0 ctermbg=239
highlight CursorWord1 term=none cterm=none gui=none

" syntax keyword pythonDefOrClass def class nextgroup=pythonFunctionDef skipwhite
au FileType python syntax keyword pythonDefOrClass def class nextgroup=pythonFunctionDef skipwhite
au FileType python syntax match pythonDefOrClass /\<async def\>/ nextgroup=pythonFunctionDef skipwhite
