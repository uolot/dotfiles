" reverse lines order
command -range Reverse <line1>,<line2>!tac

" open the scratchpad
command Scratchpad e ~/scratchpad

function! PopOut(close)
    let p = expand('%:p:h')
    let f = expand('%:p')
    let l = line('.')
    " let b:dispatch = 'alacritty --working-directory ' . p . ' -t floating -e vim ' . f . ':' . l . ' +"Dispatch! source venv/bin/activate"'
    " let b:dispatch = 'alacritty --working-directory ' . p . ' -t floating -d 100 30 -e vim ' . f . ':' . l . ' +"Dispatch! source venv/bin/activate"'
    " let b:dispatch = "sway exec \"alacritty --working-directory " . p . " -t floating -d 100 30 -e vim " . f . ":" . l . "\""
    let b:dispatch="$HOME/Bin/ala-vim " . f . " " . l
    " echo b:dispatch
    " return
    Dispatch
    if a:close == 1
        quit
    endif
    normal <C-w>=
endfunction

nnoremap <Leader>po :call PopOut(0)<CR>
nnoremap <Leader>pO :call PopOut(1)<CR>
