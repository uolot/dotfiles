" jump between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" switch between buffers
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" insert blank lines
nnoremap gO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap go  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" search for word (like grep -w)
nnoremap <Leader>s /\<\><left><left>

" reselect visual block after (un)indent
vnoremap < <gv
vnoremap > >gv

" select inserted/pasted text
nnoremap gV `[v`]


" open images with imv
autocmd BufEnter *.png,*.jpg,*.gif exec "!imv ".expand("%") | :bw
" open PDFs with zathura
autocmd BufEnter *.pdf exec "!zathura ".expand("%") | :bw


" enable/disable wrap
nnoremap <Leader>w1 :set wrap<CR>
nnoremap <Leader>w0 :set nowrap<CR>


" Use wl-clipboard for copy/paste
" Src: https://www.reddit.com/r/Fedora/comments/ax9p9t/vim_and_system_clipboard_under_wayland/
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap <Leader>yy :call system("wl-copy ", getline("."))<CR>


" save as root
cmap w!! w !sudo tee > /dev/null %
