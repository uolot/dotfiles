" https://github.com/junegunn/rainbow_parentheses.vim
Plug 'junegunn/rainbow_parentheses.vim'
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme,racket RainbowParentheses
augroup END
