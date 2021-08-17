function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return "[paste]"
    else
        return ""
    endif
endfunction

function! WrapForStatusline()
    let wrap_status = &wrap
    if wrap_status == 1
        return "[wrap]"
    else
        return ""
    endif
endfunction

set statusline=
"vim mode
set statusline +=\[%{mode()}%*\]\  "
"relative path
set statusline +=%<%f\   "
"modified / read-only flags
set statusline +=%m%r%w
"file type
set statusline +=%y
"paste status
set statusline +=%{PasteForStatusline()}
"fugitive
" set statusline +=%{FugitiveStatusline()}
"wrap status
set statusline +=%{WrapForStatusline()}
"zoom status
set statusline +=%{zoom#statusline()}
"truncate if needed
set statusline +=%<
" left/right separator
set statusline +=%=
"current line / total lines
set statusline +=%5l/%L
"virtual column number
set statusline +=%4v\   "
"scroll percentage
set statusline +=%p%%\   "
