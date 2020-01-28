" Viewer & Finder for LSP symbols and tags
Plug 'liuchengxu/vista.vim'
let g:vista#renderer#icons = {
\   "variable": "v",
\   "function": "f",
\   "class": "c",
\   "member": "m",
\  }

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
" 'source': ['~/.dotfiles/vim/vimrc', '~/.dotfiles/sway/config', '~/.dotfiles/bash/bashrc', '~/.dotfiles/git/config', '~/.dotfiles/setup/install.py', '~/.dotfiles/termite/config', "~/.dotfiles/new_packages.txt"],
  let g:clap_provider_dotfiles = {
      \ 'source': globpath('~/.dotfiles', '**/*', 0, 1),
      \ 'sink': 'e',
      \ }
  let g:clap_theme = 'material_design_dark'
  nnoremap <Leader><Space><Space> :Clap<CR>
  nnoremap <Leader><Space>b :Clap buffers<CR>
  nnoremap <Leader><Space>c :Clap command<CR>
  nnoremap <Leader><Space>d :Clap dotfiles<CR>
  nnoremap <Leader><Space>f :Clap files<CR>
  nnoremap <Leader><Space>g :Clap git_files<CR>
  nnoremap <Leader><Space>h :Clap command_history<CR>
  nnoremap <Leader><Space>l :Clap lines<CR>
  nnoremap <Leader><Space>t :Clap tags<CR>
  nnoremap <Leader><Space>w :Clap grep ++query=<cword><CR>
  nnoremap <Leader><Space>/ :Clap grep ++query=


