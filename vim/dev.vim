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
