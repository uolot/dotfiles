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
    " This should work, but it doesn't: call neomake#configure#automake('w')
    autocmd! BufWritePost * Neomake
    noremap <Leader>e :Neomake<CR>
    let g:neomake_python_enabled_makers = ['pylama', 'mypy']

    " E510 - line too long
    " W605 - invalid escape sequence
    let g:neomake_python_pylama_maker = { 'args': ['--ignore=E501,W605'],  }
