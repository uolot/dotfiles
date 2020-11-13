Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#popup_on_dot = 1

    let g:jedi#goto_command = '<leader>jg'
    let g:jedi#goto_assignments_command = '<leader>ja'
    let g:jedi#goto_definitions_command = '<leader>jd'
    let g:jedi#rename_command = '<leader>jr'
    let g:jedi#usages_command = '<leader>ju'
    let g:jedi#goto_stubs_command = '<leader>js'

    autocmd FileType python setlocal completeopt-=preview

autocmd FileType python set autoread
autocmd FileType python let b:dispatch = 'isort % ; black %'
autocmd BufWritePost *.py Dispatch!
autocmd CursorHold * if getcmdwintype() == '' | checktime | endif
autocmd BufWritePost *.py checktime

autocmd FileType python iabbrev ifmain if __name__ == "__main__"
autocmd FileType python iabbrev adef async def
autocmd FileType python iabbrev awith async with
