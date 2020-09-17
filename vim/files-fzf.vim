Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
    nnoremap <Leader>pf :GFiles<CR>
    nnoremap <Leader>pF :Files<CR>
    nnoremap <Leader>pl :Lines<CR>
    nnoremap <Leader>bl :BLines<CR>
    nnoremap <Leader>pt :Tags<CR>
    nnoremap <Leader>bt :BTags<CR>
    nnoremap <Leader>pb :Buffers<CR>
    " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction
nnoremap <leader>ff :call FzyCommand("fd -i -t f -E __pycache__", ":e")<cr>
