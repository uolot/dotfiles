Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
    nnoremap <Leader>ff :GFiles<CR>
    nnoremap <Leader>pf :Files<CR>
    nnoremap <Leader>pl :Lines<CR>
    nnoremap <Leader>bl :BLines<CR>
    nnoremap <Leader>pt :Tags<CR>
    nnoremap <Leader>bt :BTags<CR>
    nnoremap <Leader>pb :Buffers<CR>
    " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    nnoremap <Leader>* :Ag <C-r><C-w><CR>
    nnoremap <Leader>g* :Ag <C-r><C-a><CR>

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
nnoremap <leader>fy :call FzyCommand("fd -i -t f -E __pycache__", ":e")<cr>
