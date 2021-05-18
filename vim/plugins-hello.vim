" One second to read GitHub code with vim
" https://github.com/drzel/vim-repo-edit
Plug 'drzel/vim-repo-edit'


" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'


" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <leader>nn :NERDTreeFocus<CR>
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'


" See the contents of the registers
" https://github.com/junegunn/vim-peekaboo
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay = 1000


" Undo tree visualizer
" https://github.com/simnalamburt/vim-mundo
" https://simnalamburt.github.io/vim-mundo/
Plug 'simnalamburt/vim-mundo'
nnoremap <Leader>mt :MundoToggle<CR>


" Run normal commands over text objects
" https://github.com/JRasmusBm/vim-peculiar
Plug 'JRasmusBm/vim-peculiar'
nmap <Leader>pn <Plug>PeculiarN
nmap <Leader>pr <Plug>PeculiarR
nmap <Leader>pg <Plug>PeculiarG
nmap <Leader>pv <Plug>PeculiarV
