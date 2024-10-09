" ------ General settings ------

filetype plugin indent on " enables filetype specific plugins

lua require('options')

" automatically equalize splits when vim is resized
autocmd VimResized * wincmd =

" source $HOME/.dotfiles/neovim/plugins.vim

lua require('main')

augroup markdown_highlights
    highlight Headline1 guifg=Yellow
    highlight Headline2 guifg=Orange
    highlight Headline3 guifg=LightGreen
    highlight Headline4 guifg=Cyan
    highlight Headline5 guifg=Pink
augroup end

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=350 }
augroup end

au FileType json setlocal conceallevel=0
au FileType jsonc setlocal conceallevel=0
