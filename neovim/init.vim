" ------ General settings ------

filetype plugin indent on " enables filetype specific plugins

" TODO: change to vim.g.mapleader = " "
let mapleader=" "

lua require('options')

" automatically equalize splits when vim is resized
autocmd VimResized * wincmd =

" source $HOME/.dotfiles/neovim/plugins.vim

lua require('main')

source $HOME/.dotfiles/neovim/vimwiki.vim

" maps
source $HOME/.dotfiles/neovim/mappings.vim

" abbrevs
source $HOME/.dotfiles/neovim/abbrev.vim

augroup markdown_highlights
    highlight Headline1 guifg=Yellow
    highlight Headline2 guifg=Orange
    highlight Headline3 guifg=LightGreen
    highlight Headline4 guifg=Cyan
    highlight Headline5 guifg=Pink
augroup end

" bg for hl_match_area
highlight MatchArea guibg=#303030

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=350 }
augroup end

hi! ColorColumn guifg=#adbac7 guibg=#2d3239


" DiffOrig
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Auto-commit & push ZK files
function! AutoCommit()
    AsyncRun bash $HOME/Bin/zk-commit.sh ${VIM_FILEPATH}
endfun
autocmd BufWritePost $ZK_NOTEBOOK_DIR/*.md call AutoCommit()
autocmd BufWritePost $ZK_NOTEBOOK_DIR/**/*.md call AutoCommit()

" reverse lines order
command -range Reverse <line1>,<line2>!tac

" vsnip snippets dir
let g:vsnip_snippet_dir = "$HOME/.dotfiles/neovim/vsnip/"

au FileType json setlocal conceallevel=0
au FileType jsonc setlocal conceallevel=0

" For VS Code:
" exists('g:vscode')
