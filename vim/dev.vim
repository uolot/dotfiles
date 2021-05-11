" auto-generate ctags file
Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_project_root = [
        \'docker-compose.yml',
        \'Makefile',
        \'pyproject.toml',
        \'.python-version',
        \'README',
        \'README.md'
        \'requirements.txt',
        \'setup.py',
    \]

Plug 'neomake/neomake'
    let g:neomake_open_list = 2
    " call neomake#configure#automake('w') -> Moved to vimrc, after calling
    " `plug#end()`
    " autocmd! BufWritePost * Neomake
    noremap <Leader>e :Neomake<CR>
    let g:neomake_python_enabled_makers = ['flake8', 'pylama', 'mypy']
    let g:neomake_cpp_enabled_makers = []

    " E510 - line too long
    " W503 - line break before binary operator
    " W605 - invalid escape sequence
    let g:neomake_python_pylama_maker = { 'args': ['--ignore=E501,W503,W605'],  }
    let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501,W503,W605'],  }


Plug 'sheerun/vim-polyglot'
    " TODO: Remove plugins duplicated by polyglot:
    " https://github.com/sheerun/vim-polyglot#language-packs
    let g:polyglot_disabled = ['python']
    let g:terraform_fmt_on_save = 1
    let g:terraform_align = 1
    let g:vim_markdown_conceal_code_blocks = 0
    let g:vim_markdown_follow_anchor = 1  " follow named anchors
    let g:vim_markdown_no_extensions_in_markdown = 1
    let g:vim_markdown_strikethrough = 1  " ~~scratch this~~
    autocmd FileType markdown setlocal tw=0 wrap

Plug 'tpope/vim-commentary'

Plug 'jpalardy/vim-slime'
    let g:slime_target = "tmux"
    let g:slime_python_ipython = 1
    let g:slime_cell_delimiter = "#"
    nmap <C-c><C-l> <Plug>SlimeLineSend
    nmap <C-c><C-m> <Plug>SlimeMotionSend
    nmap <C-c><C-e> <Plug>SlimeMotionSend
    function! Slime_ipython_toggle()
        if !exists('g:slime_python_ipython') || g:slime_python_ipython == 0
            let g:slime_python_ipython = 1
        else
            unlet g:slime_python_ipython
        endif
    endfunction
    nmap <C-c><C-i> :silent! call Slime_ipython_toggle()<CR>

" make vim understand ANSI escape sequences
Plug 'vim-scripts/AnsiEsc.vim'
    " fix for cecutil plugin (used by AnsiEsc.vim) mapping to <Leader>rwp and
    " <Leader>swp that break my own leader mappings
    function! Unmap_cecutil()
      unmap <Leader>rwp
      unmap <Leader>swp
    endfunction
    autocmd BufEnter * silent! call Unmap_cecutil()

" Arduino/PlatformIO
Plug 'vim-scripts/Arduino-syntax-file'

" Allow sending commands to vim via rpc
Plug 'roxma/vim-hug-neovim-rpc'

" TabNine
Plug 'codota/tabnine-vim', { 'on': 'TN' }
nnoremap <Leader>tn :silent! TN<CR>

" Parinfer mode
Plug 'eraserhd/parinfer-rust', {
        \ 'for': 'clojure',
        \ 'do': 'cargo build --release'
        \ }

" generate table of contents in markdown files
" commands: :GenTocGFM / :UpdateToc / :RemoveToc
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
    let g:vmt_auto_update_on_save = 1
    let g:vmt_fence_text = 'TOC'
    let g:vmt_fence_closing_text = '/TOC'
    let g:vmt_fence_hidden_markdown_style = 'GFM'

" find TODO notes in current buffer
command! Todos /\(TODO\|XXX\|FIXME\)

" dart+flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
