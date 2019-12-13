Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    nnoremap <Leader>pf :GFiles<CR>
    nnoremap <Leader>pF :Files<CR>
    nnoremap <Leader>pl :BLines<CR>
    nnoremap <Leader>pL :Lines<CR>
    nnoremap <Leader>pt :Tags<CR>
    nnoremap <Leader>pb :Buffers<CR>

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

" handle line and column numbers in file names, eg: file.txt:10 or file.txt:10:5
Plug 'kopischke/vim-fetch'

" guess file indentation style
Plug 'conormcd/matchindent.vim'
