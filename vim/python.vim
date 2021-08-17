Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0

    let g:jedi#goto_command = '<leader>gg'
    let g:jedi#goto_assignments_command = '<leader>ga'
    let g:jedi#goto_definitions_command = '<leader>gd'
    let g:jedi#goto_stubs_command = '<leader>gs'
    let g:jedi#usages_command = '<leader>gu'
    let g:jedi#rename_command = '<leader>gr'

    autocmd FileType python setlocal completeopt-=preview

" Generate Python docstring to your Python source code
" https://github.com/heavenshell/vim-pydocstring
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
    let g:pydocstring_enable_mapping = 0
    let g:pydocstring_formatter = 'google'
    let g:pydocstring_doq_path = '/home/tomasz/.local/bin/doq'
    let g:pydocstring_templates_path = '/home/tomasz/.dotfiles/doq'
    nnoremap <Leader>pd :Pydocstring<CR>
    xnoremap <Leader>pd :Pydocstring<CR>
    nnoremap <Leader>pD :PydocstringFormat<CR>

" highlight Python source code lines that lack test coverage
" https://github.com/mgedmin/coverage-highlight.vim
Plug 'mgedmin/coverage-highlight.vim'
" :HighlightCoverage


autocmd FileType python iabbrev ifmain if __name__ == "__main__"
autocmd FileType python iabbrev adef async def
autocmd FileType python iabbrev awith async with
autocmd FileType python iabbrev bp breakpoint()
autocmd FileType python iabbrev ffia from __future__ import annotations

" Poor man's snippets
autocmd FileType python nnoremap <Leader><Space>nq A  # noqa<Esc>
autocmd FileType python nnoremap <Leader><Space>ns A  # nosec<Esc>
autocmd FileType python nnoremap <Leader><Space>pd A  # pylint: disable=
autocmd FileType python nnoremap <Leader><Space>ti A  # type: ignore<Esc>

